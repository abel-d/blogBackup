---
title: 分享一个自用的部署和备份blog的脚本
date: 2018-01-15 15:59:38
tags: 部署 备份
---

##### 此脚本就是把要手工输入的重复工作写成了shell，脚本如下

```powershell
#!/user/bin/bash
#backup blog source code
hexo clean
git add .
git commit -m "backup blog"
git push 

#deploy blog to another repo
hexo g
#hexo d 下面的cd命令是进入要上传到GitHub上的目录，~ ：这个建议全路径，我式为隐藏我的home目录才改的
cd ~/GitProject/gitHubBlog/abel-d.github.io
cp -R ~/GitProject/gitHubBlog/blog/public/* /Users/abel_d/GitProject/gitHubBlog/abel-d.github.io

git add .
git commit -m "update gitHubBlog"
git push 
```

##### 脚本编写完成就是执行了

​    `sh 你的脚本名字.sh`

---

[hexo官方命令文档](https://hexo.io/zh-cn/docs/commands.html)

[git教程推荐廖雪峰大神的](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)