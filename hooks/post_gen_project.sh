#!/usr/bin/env bash

set -euo pipefail
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
IFS=$'\n\t'

#
# Functions:
#

function echo_info() {
	echo "[GoApiStaterKit] INFO post_gen_project.sh - $1" >&1
}

#
# Step 1:
#

if [[ "{{cookiecutter.use_docker}}" =~ ^[Nn] ]]; then
	rm -rf docker/ compose/
fi

#
# Step 2:
#

if [[ "{{cookiecutter.use_rest_http}}" =~ ^[Yy] ]]; then
	echo_info "Install rest.http extension for vscode"
	curl -sLO https://raw.githubusercontent.com/coderj001/PhoneGuardian/master/rest.http
fi

#
# Step 3:
#

if [[ "{{cookiecutter.use_github_action}}" =~ ^[Nn] ]]; then
	rm -rf .github/
fi

#
# Step 4:
#

echo_info "Setup env"
cp env.example .env
echo """

# JWT Secret
JWT_SECRET=$(openssl rand -base64 32)
""" >> .env

#
# Step 5:
#

echo_info "Initializing Go"
go mod tidy

#
# Step 6:
#

echo_info "Initializing Git"
git init
git add .
git commit -n -m "🔧 chore: initial commit"

#
# Done:
#

echo_info "Done!"
