package utils

import (
	"errors"
	"flag"
	"go/ast"
	"go/parser"
	"go/token"
	"net/http"
	"os"
	"reflect"
	"strings"
	"text/template"

	"github.com/mholt/binding"
)

// UnmarshalRequest unmarshals request.FormValue into arbitrary structs based on mholt/binding
func UnmarshalRequest(r *http.Request, s interface{}) error {
	// binding uses pkg/errors so unwrap to return stdlib error
	if sBinding, ok := s.(binding.FieldMapper); ok {
		return errors.Unwrap(binding.Bind(r, sBinding))
	}

	return errors.New("Server Error - Request not Implemented")
}


// BindTemplate is the top-level struct passed to template.Execute()
type BindTemplate struct {
	Package string
	Structs []*ParsedStruct
}

// ParsedStruct represents a single tagged struct to generate bindings for
type ParsedStruct struct {
	Name   string
	Token  string
	Fields map[string]*ParsedTag
}

// ParsedTag includes the tag value and a bool Required for each field
type ParsedTag struct {
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
`package {{ .Package }}

import (	
	"net/http"
	"github.com/mholt/binding"
)
{{ range .Structs }}{{ $token := .Token }}{{ $name := .Name }}
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

func generateStructBindings(file, pkg, targetTag string) (*BindTemplate, bool) {
	fset := token.NewFileSet()

	f, err := parser.ParseFile(fset, file, nil, 0)
	if err != nil {
		panic(err)
	}

	bindTemplate := &BindTemplate{
		Package: pkg,
		Structs: make([]*ParsedStruct, 0),
	}

	// Parse file Abstract Syntax Tree of file to find any Structs
	ast.Inspect(f, func(n ast.Node) bool {
		if typeSpec, ok := n.(*ast.TypeSpec); ok {
			if structType, ok := typeSpec.Type.(*ast.StructType); ok {

				// if Struct has any tagged fields add it to bindTemplate.Structs
				if parsedFields := parseFieldTags(structType, targetTag); len(parsedFields) > 0 {

					bindTemplate.Structs = append(bindTemplate.Structs,
						&ParsedStruct{
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

func parseFieldTags(structType *ast.StructType, target string) map[string]*ParsedTag {
	parsedTags := make(map[string]*ParsedTag)

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

				parsedTags[field.Names[0].Name] = &ParsedTag{value, required}
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

	f, err := os.OpenFile(*fileOut, os.O_RDWR|os.O_CREATE, 0666)
	if err != nil {
		panic(err)
	}
	defer f.Close()

	if tpl, err := template.New("BindTemplate").Parse(bindTemplateBase); err == nil {
		tpl.ExecuteTemplate(f, "BindTemplate", bindTemplateStruct)
	}
}