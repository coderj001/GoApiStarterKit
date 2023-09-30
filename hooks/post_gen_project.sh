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

if [[ echo "{{cookiecutter.use_docker}}" | grep -iq "^n" ]]; then
	rm -rf docker/ compose/
fi

#
# Step 2:
#

if [[ echo "{{cookiecutter.use_rest_http}}" | grep -iq "^n" ]]; then
	rm -rf rest.txt
elif
	echo_info "Install rest.http extension for vscode"
	mv rest.txt rest.http
fi

#
# Step 3:
#

if [[ echo "{{cookiecutter.use_github_action}}" | grep -iq "^n" ]]; then
	rm -rf .github/
fi

#
# Step 4:
#

echo_info "Setup env"
cp env.example
cp env.example .env
echo """

# JWT Secret
JWT_SECRET=$(openssl rand -base64 32)
""" >> .env

#
# Step 5:
#

echo_info "Initializing Git"
git init
git add .
git commit -n -m "🔧 chore: initial commit"

#
# Done:
#

echo_info "Done!"
