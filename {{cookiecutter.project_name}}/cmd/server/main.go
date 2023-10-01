package main

import (
	"fmt"
	"os"

	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/app"
	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/config"
)

func main() {
	config := config.GetConfig()
	app := &app.App{}
	app.Initialize(config)
	port := os.Getenv("SERVER_PORT")
	app.Run(fmt.Sprintf(":%s", port))
}

