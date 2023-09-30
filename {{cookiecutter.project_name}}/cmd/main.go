package main

import (
	"fmt"
	"os"

	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/dian/app"
	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/dian/config"
)

func main() {
	config := config.GetConfig()
	app := &app.App{}
	app.Initialize(config)
	port := os.Getenv("SERVER_PORT")
	app.Run(fmt.Sprintf(":%s", port))
}
