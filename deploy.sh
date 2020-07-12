#!/bin/sh

# Commit changes.
msg="rebuilding site `date '+%F %T'`"
if [ $# -eq 1 ]; then
  msg="$1"
fi

git commit -m "$msg"
if [ $? -ne 0 ]; then
  echo "Commit failed"
  exit 1
fi
git push origin master
if [ $? -ne 0 ]; then
  echo "Push failed"
fi

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Config
git config --replace-all user.name cupppa
git config --replace-all user.email cupppa@gmail.com

# Add changes to git.
git add .

git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..

