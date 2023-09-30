#!/usr/bin/env bash

set -euo pipefail
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

echo_info "Initializing Git"
git init
git add .
git commit -n -m "Initial Commit"

#
# Done:
#

echo_info "Done!"
