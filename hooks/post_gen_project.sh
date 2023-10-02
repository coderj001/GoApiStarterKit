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

if [[ echo "{{cookiecutter.use_rest_http}}" | grep -iq "^y" ]]; then
	echo_info "Install rest.http extension for vscode"
	touch rest.http
	echo """
@baseURL = http://localhost:8000
@token = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2ODg1NzgwMzQsImlhdCI6MTY4ODQ5MTYzNH0.03hUcVbQUOn6MX-FoWFcThvPF9PBgozJIhYWc0V9E6Q

### Test API
GET {{baseURL}}/health
Content-Type: application/json

### User Register
POST {{baseURL}}/user/register
Content-Type: application/json

{
  "name": "John Doe",
  "phone": "1234567890",
  "email": "johndoe@example.com",
  "password": "password123"
}

### User Login
POST {{baseURL}}/user/login
Content-Type: application/json

{
  "email": "johndoe@example.com",
  "password": "password123"
}

### Create Contact
POST {{baseURL}}/contact
Content-Type: application/json
Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2ODg4MDA0MTMsImlhdCI6MTY4ODcxNDAxM30.nJhkx4n7VeoyQQ0hax5hsuYFG0Yo6Q4OIN3_cFqIGUw

{
  "name": "neo ai",
  "phone_number": "1234567891"
}

### Mark as spam
POST {{baseURL}}/spam
Content-Type: application/json

{
  "phone_number": "1234567890"
}

### Search by Name
GET {{baseURL}}/search?name=neo
Content-Type: application/json
Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2ODg4MDA0MTMsImlhdCI6MTY4ODcxNDAxM30.nJhkx4n7VeoyQQ0hax5hsuYFG0Yo6Q4OIN3_cFqIGUw

### Search by Phone Number
GET {{baseURL}}/search?phone_number=1234567890
Content-Type: application/json
Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2ODg4MDA0MTMsImlhdCI6MTY4ODcxNDAxM30.nJhkx4n7VeoyQQ0hax5hsuYFG0Yo6Q4OIN3_cFqIGUw

### User Details
GET {{baseURL}}/user/1
Content-Type: application/json
	""">rest.http
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
