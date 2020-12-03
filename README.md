```
.
├── appspec.yml
├── backend
│   ├── database
│   │   ├── awsSSMParams.go
│   │   ├── dbConfigFromAWS.go
│   │   ├── dbConnector.go
│   │   └── schema.sql
│   ├── go.mod
│   ├── go.sum
│   ├── main.go
│   ├── Makefile
│   ├── models
│   │   └── models.go
│   ├── routes.go
│   ├── server.go
│   ├── static.go
│   └── utils
│       └── routeParsing.go
├── frontend
│   ├── Makefile
│   ├── media
│   │   └── icon.jpg
│   ├── package.json
│   ├── package-lock.json
│   ├── public
│   │   └── index.html
│   └── src
│       ├── App.css
│       ├── App.js
│       ├── Components
│       │   ├── ContentCard
│       │   │   ├── ContentCard.css
│       │   │   └── ContentCard.js
│       │   ├── ContentList
│       │   │   ├── ContentList.css
│       │   │   └── ContentList.js
│       │   ├── Footer
│       │   │   └── Footer.js
│       │   ├── Header
│       │   │   ├── Header.css
│       │   │   └── Header.js
│       │   ├── MainPage
│       │   │   ├── MainPage.css
│       │   │   └── MainPage.js
│       │   ├── Post
│       │   │   ├── Post.css
│       │   │   └── Post.js
│       │   └── Title
│       │       ├── Title.css
│       │       └── Title.js
│       ├── index.js
│       ├── routes.json
│       ├── Store
│       │   ├── Actions.js
│       │   └── Store.js
│       └── Utils
│           ├── ContentAPI.js
│           ├── ParseRoutes.js
│           └── RedirectRequest.js
├── infrastructure-as-code
│   ├── build-server
│   │   ├── ami
│   │   │   ├── ami.json
│   │   │   ├── Makefile
│   │   │   └── server.yml
│   │   └── container
│   │       ├── jenkins-config-as-code.yml
│   │       ├── jenkins.Dockerfile
│   │       └── Makefile
│   ├── credentials
│   │   ├── github
│   │   └── rds
│   ├── main.tf
│   ├── Makefile
│   ├── modules
│   │   ├── codedeploy_app
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── vars.tf
│   │   ├── db_with_ssm_credentials
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── vars.tf
│   │   ├── github_webhook
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── vars.tf
│   │   ├── networked_asg
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── vars.tf
│   │   └── networked_ec2
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── vars.tf
│   ├── outputs.tf
│   ├── production.tfvars
│   ├── scripts
│   │   ├── build_server.sh
│   │   └── deployment_server.sh
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── vars.tf
├── pipeline.jenkinsfile
├── README.md
└── scripts
    ├── before_install.sh
    ├── start_server.sh
    └── stop_server.sh