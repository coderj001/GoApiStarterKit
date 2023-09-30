# Cookiecutter-Goapistarterkit

### GO Projects Structure 
```bash
- /project_root
  - go.mod               # The Go module file, defining the project's dependencies.
  - README.md            # Project documentation and README file.
  - LICENSE              # Licensing information for the project.
  - Makefile             # A Makefile for building and managing the project (optional).
  - cmd/                 # Directory for application-specific commands.
    - go_project         # Subdirectory for the main application.
      - main.go          # The entry point of the application.
  - internal/            # Directory for internal packages and modules.
    - package_name/      # Subdirectory for internal packages (private to the project).
      - your_logic.go    # Go source files containing internal application logic.
  - pkg/                 # Directory for public packages (optional).
    - public_package/    # Subdirectory for public packages (can be imported by other projects).
      - public_logic.go  # Go source files containing public package logic.
  - bin/                 # Directory for compiled binary files (executable outputs).
  - test/                # Directory for test files (unit tests and integration tests).
```
1. `/project_root`: The root directory of your Go project.
2. `go.mod`: This is the Go module file. It defines the project's dependencies and is used for managing packages.
3. `README.md`: A documentation file that provides information about your project.
4. `LICENSE`: This file contains licensing information for your project, which is important for open-source projects.
5. `Makefile`: (Optional) A Makefile for defining build and project management tasks.
6. `cmd/`: A directory for application-specific commands.
7. `go_project/`: Subdirectory for the main application.
8. `main.go`: The main entry point of your Go application.
9. `internal/`: A directory for internal packages and modules.
10. `package_name/`: Subdirectory for internal packages (private to your project).
11. `your_logic.go`: Go source files containing internal application logic.
12. `pkg/`: (Optional) A directory for public packages.
13. `public_package/`: Subdirectory for public packages that can be imported by other projects.
14. `public_logic.go`: Go source files containing public package logic.
15. `bin/`: A directory where compiled binary files (executables) are stored after building.
16. `test/`: A directory for test files, which typically include unit tests and integration tests.
