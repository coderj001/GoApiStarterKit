package app

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	_ "github.com/lib/pq"
	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/app/handler"
	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/app/middleware"
	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/app/model"
	"github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_name}}/config"
)

// App has router and db instances
type App struct {
	Router *mux.Router
	DB     *gorm.DB
}

// Initialize initializes the app with predefined configuration
func (a *App) Initialize(config *config.Config) {
	dbURI := fmt.Sprintf("%s://%s:%s@%s:%d/%s?sslmode=disable",
		config.DB.Dialect,
		config.DB.Username,
		config.DB.Password,
		config.DB.Host,
		config.DB.Port,
		config.DB.Name)

	db, err := gorm.Open(config.DB.Dialect, dbURI)
	if err != nil {
		log.Fatal(err)
	}

	a.DB = model.DBMigrate(db)
	a.Router = mux.NewRouter()
	a.Router.Use(middleware.LoggingMiddleware)
	a.setRouters()
}

// setRouters sets the all required routers
func (a *App) setRouters() {
	// Get the API version from cookiecutter.json
	apiVersion := "{{ cookiecutter.api_version }}"

	// Create a base route group with the API version prefix
	apiGroup := a.Group("/" + apiVersion)

	// User-related routes
	apiGroup.Post("/user/register", a.handleRequest(handler.RegisterUser))
	apiGroup.Post("/user/login", a.handleRequest(handler.LoginUser))

	// Middleware for authenticated routes
	authMiddleware := middleware.AuthMiddleware(true)

	// Contact routes
	apiGroup.Post("/contact", authMiddleware(a.handleRequest(handler.CreateContact)))
	apiGroup.Post("/spam", a.handleRequest(handler.MarkNumberAsSpam))
	apiGroup.Get("/search", authMiddleware(a.handleRequest(handler.SearchContact)))
	apiGroup.Get("/user/{user_id}", a.handleRequest(handler.GetUserDetails))

	// Docker healthcheck API endpoint
	a.Get("/health", a.handleRequest(handler.HealthCheck))
}

// Get wraps the router for GET method
func (a *App) Get(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("GET")
}

// Post wraps the router for POST method
func (a *App) Post(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("POST")
}

// Put wraps the router for PUT method
func (a *App) Put(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("PUT")
}

// Delete wraps the router for DELETE method
func (a *App) Delete(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("DELETE")
}

// Run the app on it's router
func (a *App) Run(host string) {
	log.Println("[+] server starting...")
	log.Fatal(http.ListenAndServe(host, a.Router))
}

type RequestHandlerFunction func(db *gorm.DB, w http.ResponseWriter, r *http.Request)

func (a *App) handleRequest(handler RequestHandlerFunction) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		handler(a.DB, w, r)
	}
}
