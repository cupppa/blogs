---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Curl Usage"
subtitle: ""
summary: "Examples using curl."
authors: []
tags: ["curl"]
categories: ["mac","linux","network"]
date: 2020-07-14T10:57:14+08:00
lastmod: 2020-07-14T10:57:14+08:00
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

Some examples using curl.

<!-- more -->

## Continue file transfer 

command line

```
 curl -C - -O <url>
```

man
```
       -C, --continue-at <offset>
              Continue/Resume  a  previous  file transfer at the given offset. The given
              offset is the exact number of bytes that will be  skipped,  counting  from
              the  beginning of the source file before it is transferred to the destina‐
              tion.  If used with uploads, the FTP server command SIZE will not be  used
              by curl.

              Use  "-C -" to tell curl to automatically find out where/how to resume the
              transfer. It then uses the given output/input files to figure that out.

              If this option is used several times, the last one will be used.
```

```
       -O, --remote-name
              Write output to a local file named like the remote file we get. (Only  the
              file part of the remote file is used, the path is cut off.)

              The  remote  file  name to use for saving is extracted from the given URL,
              nothing else.

              Consequentially, the file will be saved in the current working  directory.
              If  you want the file saved in a different directory, make sure you change
              current working directory before you invoke curl with  the  -O,  --remote-
              name flag!

              You may use this option as many times as the number of URLs you have.
```
