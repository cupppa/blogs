---
title: "Tcpdump Usage"
date: 2020-07-01T11:52:38+08:00
lastmod: 2020-07-01T11:52:38+08:00
draft: false
keywords: [tcpdump]
description: ""
summary: "Some examples using tcpdump."
tags: ["tcpdump"]
categories: ["linux","network"]
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

## Tcpdump Usage

#### 查找reset包
```
tcpdump -r xxxx.pcap 'tcp[tcpflags] & tcp-rst != 0'
```

<!--more-->
