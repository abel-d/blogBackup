---
title: hexo-gitHub部署不能立刻显示原因
date: 2017-10-26 17:04:45
tags: gitHubPage error
---

- Github Pages Server是跑在UTC时区下的，我们这边一般是UTC+8，Github Pages估计只会编译server的当前时刻之前的文件。把发布时间改成前一天再试一下。
- build failure ,markdown解析错误