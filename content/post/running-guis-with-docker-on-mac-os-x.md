---
title: "Running GUI's with Docker on Mac OS X"
slug: "running-guis-with-docker-on-mac-os-x"
date: 2019-07-24T11:45:30+08:00
author: "cupppa"
tags: [ "mac", "docker", "chrome", "OS X", "Mac OS X" ]
categories: [ "docker", "mac", "chrome", "OS X", "Mac OS X" ]
draft: false
---

<p>[from] <a href="https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc">Running GUI's with Docker on Mac OS X</a></p>

<p>
We are very familiar with running CLI processes in Docker containers with no Graphical UI at all. But did you know that you can just as well run applications with a graphical user interfaces, like Chrome, Firefox, Tor Browser, Gimp, etc... with Docker... on OS X!
</p>
<p>
在Docker容器中运行无图形用户界面的命令行进程我们已很熟练。但你是否知道也可以在OSX系统中使用Docker运行有图形用户界面的应用程序，如Chrome, Firefox, Tor Browser, Gimp等等。
</p>

<p>
This article serves as transcript to <a href="https://www.youtube.com/watch?v=PKyj8sbZNYw&source=post_page">our hands-on demo</a> and as a quick refresher on how to run these kind of applications on a Mac in 5 minutes or less. For a more in depth look on how to build and run Linux GUI apps on Mac I highly recommend <a href="http://blog.alexellis.io/linux-deskto    p-on-mac/?source=post_page">the full from scratch rundown</a>, by fellow Docker Captain Alex Ellis.
</p>
<p>
本文是<a href="https://www.youtube.com/watch?v=PKyj8sbZNYw&source=post_page">动手实践演示</a>的文字记录，快速复习了如何在5分钟或更短时间内在Mac上运行这类应用程序。要想更深入了解如何在Mac上构建和运行Linux GUI应用程序，我强列推荐Docker领队Alex Ellis的<a href="http://blog.alexellis.io/linux-desktop-on-mac/?source=post_page">从零开始的要点</a>。
</p>

<!--more-->

<p>
The first thing we need is socat, a unix tool that creates two bidirectional streams between two endpoints. Our end goal is to create a connection between the docker container that runs a graphical application and the X window system on our OS X host operating system. So lets begin by creating a bridge between a network socket with a TCP listener on port 6000 (the default port of the X window system) and the X window server on my OS X host, that we’ll install and run in the next step on a unix socket.
</p>
<p>
首先我们需要的是socat，这是一个unix工具，能在两个端点之间创建两个双向流。我们的最终目标是在运行图形应用程序的Docker容器和OS X主机操作系统上的X窗口系统之间建立连接。首先让我们在侦听TCP端口6000（X窗口系统的默认端口）的网络套接字和OS X主机上的X窗口服务之间创建一个网桥，下一步我们将在一个UNIX套接字上安装并运行X窗口服务。
</p>

<img src="https://miro.medium.com/max/1400/1*5-82LVnDtodIHAScrre6nQ.png" />

```
> brew install socat
> socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

<p>
Now we’ll tackle the X window system. To run this on Mac OS X we will need Xquartz which, according to the website, is a project that offers the <a href="https://www.xquartz.org/?source=post_page">X Window System on the OS X operating system</a>. We can either install by downloading a dmg from the website. But since we are good developers we’ll do it from the command line through homebrew. (and yes, I do see the irony in saying that when advertising this post as being all about GUI’s…)
</p>
<p>
现在我们着手X窗口系统。要在Mac OS X上运行这个程序，我们需要Xquartz，该网站上介绍，这个项目提供了<a href="https://www.xquartz.org/?source=post_page">OS X操作系统的X窗口系统</a>。我们可以通过从网站下载DMG来安装。但由于我们是优秀的开发者，我们将用命令行通过homebrew来完成这项工作。（是的，确实讽剌的是，我这篇文章宣传的是关于图形用户界面的...）
</p>

```
> brew install xquartz
```

<p>
One important thing to note is that after you have installed this is to log out and log back into OS X to get everything to work properly. Once that is done we can start Xquartz.
</p>
<p>
需要注意的一件重要的事情是，在安装完成之后，您需要注销并重新登录到OS X，以使一切正常工作。完成后，我们可以启动Xquartz。
</p>

```
> open -a Xquartz
```

<p>
A white terminal window will pop up. Now open up the preferences from the top menu and go to the last tab ‘security’. There we need to make sure the “allow connections from network clients” is checked “on”.
</p>
<p>
会弹出一个白色终端窗口。现在找开顶部菜单中的首选项并转到最后一个选项卡“安全性”。需要确保“允许来自网络客户端的连接”选项为“开启”状态。
</p>

<img src="https://miro.medium.com/max/1400/1*zMO-bPar1Z1AUUH-O2WBfw.png" />

<p>
And now we get down to business… running the actual graphical application within a Docker container!
</p>
<p>
现在我们谈正事......在Docker容器中运行实际的图形应用程序！
</p>

<img src="https://miro.medium.com/max/1400/1*t9RTn9w0PwQAMtK1yrq1GQ.png" />
<center><p style="color:#888;font-size:12px;">docker container connecting to the X window system on the host OS X through socat</p></center>

<p>
First we need the ip of the network interface of our host OS. Then we pass that on as the `DISPLAY` environment variable in the Docker container that runs the graphical interface.
</p>
<p>
首先，我们需要主机操作系统的网络接口的IP。然后，我们将其做为"DISPLAY"环境变量的值传递给运行图形界面的Docker容器。
</p>

```
> ifconfig en0
en0:
...
inet 192.168.0.235 netmask 0xffffff00 broadcast 192.168.199.255
...

> docker run -e DISPLAY=192.168.0.235:0 gns3/xeyes
```

<img src="https://miro.medium.com/max/1400/1*fBaWucXOW_r9h2sZlfJPNQ.png" />

<p>
All that trouble just to have 2 rolling eyes on your screen? Of course there is way more to explore. What about running <a href="https://hub.docker.com/r/jess/chrome/?source=post_page">chrome in a container</a>? Apart from some extra permissions and a couple of warnings… easy as pie!
</p>
<p>
这么麻烦只是在您的屏幕上有了两只滚动的眼睛？当然还有更多的方案可以探索。在<a href="https://hub.docker.com/r/jess/chrome/?source=post_page">容器中运行Chrome</a>怎么样？除了一些额外的权限和一些警告之外......很简单！
</p>

```
> docker run -e DISPLAY=192.168.0.235:0 --privileged jess/chrome
```

<img src="https://miro.medium.com/max/1400/1*R4PKVQZfCcLoGkWXJrVoRA.png" />

<p>
The possibilities are endless! So in just a couple of commands we’ve shown that docker shouldn’t be just used for the typical non-graphical applications. It can just be used as well for <a href="https://hub.docker.com/u/jess/?source=post_page">graphical apps</a>. What use cases do you see valuable with this setup?
</p>
<p>
可能性是无限的！因此，通过几个命令我们已经展示了Docker不应该仅仅用于典型的非图形应用程序。它也可以用于<a href="https://hub.docker.com/u/jess/?source=post_page">图形应用程序</a>。对于这种机制您还能设想到什么有价值的用例？
</p>

<p><i>Check out our hands-on demo in the video below!</i></p>

<iframe src="https://cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fwww.youtube.com%2Fembed%2FPKyj8sbZNYw%3Ffeature%3Doembed&url=http%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DPKyj8sbZNYw&image=https%3A%2F%2Fi.ytimg.com%2Fvi%2FPKyj8sbZNYw%2Fhqdefault.jpg&key=a19fcc184b9711e1b4764040d3dc5c07&type=text%2Fhtml&schema=youtube" frameborder="0" height="440" width="720" title="Running GUI's with Docker on OS X" class="fz p q fy ac"></iframe>
<center><p style="color:#888;font-size:12px;">Running graphical applications on mac OS X live demo</p></center>
