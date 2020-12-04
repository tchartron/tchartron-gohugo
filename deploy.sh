#!/bin/sh

# If a command fails then the deploy stops
set -e

if [ -d "public" ]
then
    printf "\033[0;32mRemoving public folder except .git to keep the submodule...\033[0m\n"
    cd public
    find . -not -name '.git' -not -name 'README.md' -delete
    cd ..
fi

printf "\033[0;32mDeploying updates to GitHub pages...\033[0m\n"

# Build the project.
# hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo -t zdoc

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi
git commit -m "$msg"
# Push source and build repos.
git push origin main
