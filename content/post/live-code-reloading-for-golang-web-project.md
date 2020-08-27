---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Live Code Reloading for Golang Web Project"
subtitle: ""
summary: "Live code reloading for golang with Makefile and fswatch"
authors: []
tags: [ "golang", "web" ]
categories: [ "mac" ]
date: 2020-07-27T17:03:38+08:00
lastmod: 2020-07-27T17:03:38+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
refer to: [Live code reloading for Golang web projects in 19 lines](https://medium.com/@olebedev/live-code-reloading-for-golang-web-projects-in-19-lines-8b2e8777b1ea)

## Create a Makefile

```
PID      = /tmp/awesome-golang-project.pid
FILES    = $(wildcard *.go) $(wildcard */*.go) $(wildcard layouts/*/*.html) $(wildcard layouts/*/*/*.html)
GOFILES  = $(wildcard *.go) $(wildcard */*.go)
APP      = ./awesome-golang-project

serve: restart
	@fswatch -e '.*\.sw.$' -e '.*~$' -o . | xargs -n1 -I{} make restart || make kill

kill:
	@test ! -f $(PID) || kill `cat $(PID)` || true
	@test ! -f $(PID) || rm $(PID) || true

before:
	@echo "----------------"
	@date
	@echo "----------------"

$(APP): $(FILES)
	@go build $(GO_FILES) -o $@

restart: before kill $(APP)
	@$(APP) & echo $$! > $(PID)

build:
	@go build .

.PHONY: serve restart kill before # let's go to reserve rules names
```

Notice: attention restart command line `@$(APP) & echo $$! > $(PID)`, do not use `@go run .` instead, because golang will build a temporary executable file and execute it, than the `$$!` is not the final process id. (here is result with golang version 1.13).

## Usage

```
brew install fswatch
make serve
```
