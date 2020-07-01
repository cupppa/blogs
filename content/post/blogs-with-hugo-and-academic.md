---
title: "Blogs With Hugo and Academic"
date: 2020-07-01T23:07:31+08:00
tags: []
draft: true
---

## Blog Site with Hugo and Academic

#### Install Hugo

- Windows
```
scoop install hugo
# or
choco install hugo
```

- Mac
```
brew install hugo
```

- Linux
```
snap install hugo
```

#### Create New Site
```
hugo new site blogs
```

#### Add Submodule

```
cd blogs
git submodule add https://github.com/gcushen/hugo-academic.git .\themes\academic
git submodule init
git submodule update
```
