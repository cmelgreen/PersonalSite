package main

import (
	"flag"
	"go/ast"
	"go/parser"
	"go/token"
	"os"
	"reflect"
	"strings"
	"text/template"

)


// bindTemplate is the top-level struct passed to template.Execute()
type bindTemplate struct {
	Package string
	Structs []*parsedStruct
}

// parsedStruct represents a single tagged struct to generate bindings for
type parsedStruct struct {
	Name   string
	Token  string
	Fields map[string]*parsedTag
}

// parsedTag includes the tag value and a bool Required for each field
type parsedTag struct {
	Value    string
	Required bool
}

// Example code generated from template with required and optional fields:
//
// func (p *Person) FieldMap(r *http.Request) binding.FieldMap {
// 	return binding.FieldMap {
// 		&p.Age: "age",
// 		&p.Name: binding.Field{
// 		 	Form: "name",
// 			Required: true,
// 		},
// 	}
// }

const bindTemplateBase = (
`// Code generated by go generate; DO NOT EDIT.

package {{ .Package }}

import (	
	"net/http"
	"github.com/mholt/binding"
)
{{ range .Structs }}{{ $token := .Token }}{{ $name := .Name }}
// FieldMap is auto-generated from struct tags to provide bindings for with mholt/binding
func ({{ $token }} *{{ $name }}) FieldMap(r *http.Request) binding.FieldMap {
	return binding.FieldMap {
		{{- range $field, $tag := .Fields }}
		&{{ $token }}.{{ $field }}:  
		{{- if not $tag.Required }} "{{ $tag.Value }}",
		{{- else }} binding.Field{
		 	Form: "{{ $tag.Value }}",
			Required: true,
		},{{ end }}{{ end }}
	}
}
{{ end -}}
`)

const requiredFieldFlag = ",required"

func generateStructBindings(file, pkg, targetTag string) (*bindTemplate, bool) {
	fset := token.NewFileSet()

	f, err := parser.ParseFile(fset, file, nil, 0)
	if err != nil {
		panic(err)
	}

	bindTemplate := &bindTemplate{
		Package: pkg,
		Structs: make([]*parsedStruct, 0),
	}

	// Parse file Abstract Syntax Tree of file to find any Structs
	ast.Inspect(f, func(n ast.Node) bool {
		if typeSpec, ok := n.(*ast.TypeSpec); ok {
			if structType, ok := typeSpec.Type.(*ast.StructType); ok {

				// if Struct has any tagged fields add it to bindTemplate.Structs
				if parsedFields := parseFieldTags(structType, targetTag); len(parsedFields) > 0 {

					bindTemplate.Structs = append(bindTemplate.Structs,
						&parsedStruct{
							Name:   typeSpec.Name.Name,
							Token:  strings.ToLower(string(typeSpec.Name.Name[0])),
							Fields: parsedFields,
						})
				}
			}
		}

		return true
	})

	// Return ok == true as long as bindTemplate contains any structs
	return bindTemplate, len(bindTemplate.Structs) > 0
}

func parseFieldTags(structType *ast.StructType, target string) map[string]*parsedTag {
	parsedTags := make(map[string]*parsedTag)

	// For each field cast non-nil tags to reflect.StructTag and add target value to map
	for _, field := range structType.Fields.List {
		if tag := field.Tag; tag != nil {
			if value, ok := (reflect.StructTag)(strings.Trim(tag.Value, "`")).Lookup(target); ok {
				required := false

				// mholt/binding includes option for required fields that needs to be evaluated
				if strings.HasSuffix(value, requiredFieldFlag) {
					value = strings.TrimSuffix(value, requiredFieldFlag)
					required = true
				}

				parsedTags[field.Names[0].Name] = &parsedTag{value, required}
			}
		}
	}

	return parsedTags
}

func main() {
	pkg := flag.String("package", "main", "package to export bindings to; default = main")
	fileIn := flag.String("f", "models.go", "file to generate bindings for; default = models.go")
	fileOut := flag.String("out", "static.go", "file to save bindings in; default = bindings.go")
	targetTag := flag.String("tag", "request", "tag key to evalute; default = request")

	flag.Parse()

	bindTemplateStruct, ok := generateStructBindings(*fileIn, *pkg, *targetTag)
	if !ok {
		panic("Couldn't bind template")
	}

	os.Remove(*fileOut)
	f, err := os.OpenFile(*fileOut, os.O_WRONLY|os.O_CREATE, 0666)
	if err != nil {
		panic(err)
	}
	defer f.Close()

	if tpl, err := template.New("BindTemplate").Parse(bindTemplateBase); err == nil {
		tpl.ExecuteTemplate(f, "BindTemplate", bindTemplateStruct)
	}
}