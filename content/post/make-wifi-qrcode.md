---
title: "Make Qrcode of Home Wifi"
date: 2020-06-29T15:55:22+08:00
lastmod: 2020-06-29T15:55:22+08:00
draft: false
keywords: [qrcode, wifi, python]
description: ""
tags: ["qrcode", "wifi", "python"]
categories: ["qrcode","wifi","python"]
author: "cupppa@gmail.com"

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

### 使用python代码制作wifi二维码

<!--more-->

```
$ pip install wifi-qrcode-generator
```

```
$ wifi-qrcode-generator
SSID: SOMESSID
Is the network hidden (default is false): y
Authentication types: WPA/WPA2, WEP, nopass
Authentication type (default is WPA/WPA2):
Password: 
The qr code has been stored in the current directory.
```

```
$ ls -l SOMESSID.png
-rw-r--r--  1 cupppa  staff  837  6 29 16:11 SOMESSID.png
```
