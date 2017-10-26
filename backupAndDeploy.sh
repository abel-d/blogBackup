#!/user/bin/bash
hexo clean
hexo g
hexo d
#git status
git add .
git commit -m "backup blog"
git push 
