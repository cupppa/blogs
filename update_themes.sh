#!/usr/bin/env bash

# check for prerequisites
if [ ! -d .git ]; then
  echo "ERROR: for Git repositories only"
  exit 1
fi

function view_update () {
    echo -e "\nChecking for updates of academic...\n"
    cd themes/academic
    git fetch
    git log --pretty=oneline --abbrev-commit --decorate HEAD..origin/master
    cd ../../

    echo -e "\nChecking for updates of cupper...\n"
    cd themes/cupper
    git log --pretty=oneline --abbrev-commit --decorate HEAD..origin/master
    cd ../../

    echo -e "\nChecking for updates of jane...\n"
    cd themes/jane
    git log --pretty=oneline --abbrev-commit --decorate HEAD..origin/master
    cd ../../
}

function do_update () {
    git submodule update --remote --merge
}

version=$(sed -n 's/^version = "//p' themes/academic/data/academic.toml)
echo -e "Source Themes Academic v$version\n"

view_update

do_update
