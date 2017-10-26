#!/user/bin/bash
#back blog source code
git add .
git commit -m "backup blog"
git push 

#deploy blog to another repo
hexo clean
hexo g
#hexo d
cd /Users/abel_d/GitProject/gitHubBlog/abel-d.github.io
cp -R /Users/abel_d/GitProject/gitHubBlog/blog/public/* /Users/abel_d/GitProject/gitHubBlog/abel-d.github.io

git add .
git commit -m "backup blog"
git push 
