---
title: Git配置多用户
date: 2018-03-14 21:19:16
tags: 
---

##### 一、起因

> 我的gitHub和码云都是用的同一个邮箱注册的并且用户名也一样，所以一份`SSH`公钥可以共用，某一天去了另一家公司给我配置了另外一个邮箱，并且其有自己的gitHub实现，那么问题来了，**两个邮箱的git用户怎么并存?**

##### 二、经过

> \#如果你想都使用`ssh clone`代码库 ，那么
>
> ` cd ~/.ssh`
>
> `ssh-keygen -t rsa -C "youremail@xx.com"`
>
> \#两个邮箱当然两个`id_rsa_xxx`,保证这两个名称不一样

上面执行完以后，添加对应的`id_rsa_xxx.pub`到对应的版本库设置下的`SSH`公钥中。

**最后**，修改或新建名为`config`的配置文件，如下

```xml
# Host后面写一个url_A,如果有端口则加上Port参数
Host url_A           (github.com)
    User yourgit_username
    Hostname url_A   (github.com)
    IdentityFile ~./ssh/id_rsa
    (Port your_port)
```



#### 三、结果

说一说git的配置文件优先级

> 1. `/etc/gitconfig`:适用于系统用户，范围最大，优先级最低，一般没用`--system`配置过则没这个配置文件
> 2. `~/.gitconfig`：全局配置文件，优先级高于`1`，用`--global`指定
> 3. 项目里`.git/config`:克隆一个库就有一个次目录，优先级最高

提供一个备用方案，万一你克隆`SSH`协议的`Url`没成功呢，尴尬不失礼貌的用下面的方法，还不用改你的全局配置。

> Https克隆代码会先读全局配置的user.name和user.email，与目标库用户名不匹配的话会让你输入的。
>
> 然后，进入克隆好的项目中执行以下命令，
>
> git config user.name = yourname
>
> git config user.email = youremail



------

参考

[Git config配置](http://blog.csdn.net/joe_007/article/details/7276195)

[Git多用户配置](https://www.jianshu.com/p/b02645fff791)