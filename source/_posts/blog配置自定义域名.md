---
title: blog配置自定义域名
date: 2018-01-15 15:46:59
tags: 域名
---

1. 买域名，阿里云买的方便省事。域名买了备案还要个2周时间

2. 在阿里云进入控制台，依次点击**域名**—>**云解析`DNS`**—>**解析设置**，点击**新手引导**，填入`gitHub blog`的`IP`地址

   ```
   这两个IP由gitHub提供 
   > 192.30.252.153
   > 192.30.252.154
   ```

3. 配置完成可以用如下命令测试是否成功
   `dig +noall +answer 你的域名(如我的:canondin.cn)`

   ```shell
   $ dig canondin.cn  +noall +answer
   ; <<>> DiG 9.9.7-P3 <<>> canondin.cn +noall +answer

   ;; global options: +cmd

   canondin.cn.		30	IN	A	192.30.252.154

   canondin.cn.		30	IN	A	192.30.252.153

   ```

4. 进入gitHub，找到你的博客项目，点击**Settings**，找到**GitHub Pages**下面的**Custom domain**填入你购买的域名，点击**Save**。等待几秒后，就可以用此域名访问你的`gitHub`博客啦

------

帮助文档中看到的DNS解析的记录类型说明

- A record，将域名指向一个IPV4地址
- CNAME，将域名指向另外一个域名

[gitHub添加域名帮助](https://help.github.com/articles/adding-or-removing-a-custom-domain-for-your-github-pages-site/)

[gitHub设置域名帮助](https://help.github.com/articles/setting-up-an-apex-domain/)