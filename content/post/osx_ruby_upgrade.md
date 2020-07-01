---
title: "Upgrade Ruby for MAC OSX"
date: 2018-04-14T10:32:40+08:00
lastmod: 2018-04-14T10:32:40+08:00
draft: true
keywords: ["ruby", "mac"]
description: ""
tags: ["ruby", "mac"]
categories: [development]
author: ""

# You can also close(false) or open(true) something for this content.
# P.S. comment can only be closed
comment: false
toc: false
autoCollapseToc: false
# You can also define another contentCopyright. e.g. contentCopyright: "This is another copyright."
contentCopyright: false
reward: false
mathjax: false
---

## Install rvm

```shell
curl -L https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash -s stable
```

## Install ruby

```shell
rvm requirements
rvm install 2.3.2
```

<!--more-->

