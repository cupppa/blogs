---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Mac Usage"
subtitle: ""
summary: "Some config to using mac."
authors: []
tags: ["bash","terminal"]
categories: ["mac"]
date: 2020-07-14T11:32:17+08:00
lastmod: 2020-07-14T11:32:17+08:00
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

## Terminal colors
```
cat > ~/.bash_profile <<EOF
# enable color in the terminal bash shell
export CLICOLOR=1
# setup the color scheme for list
export LSCOLORS=gxfxcxdxbxegedabagacad
# setup the prompt color
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
# enable color for terminal
export TERM=xterm-256color
EOF
```