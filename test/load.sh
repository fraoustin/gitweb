#!/bin/bash
cd /tmp
git clone http://gituser:gitpassword@localhost:8080/test.git
cd test
git branch master
git checkout master
git commit -m "branch master" --allow-empty
git push --set-upstream origin master
git branch develop
git checkout develop
git commit -m "branch develop" --allow-empty
git push --set-upstream origin develop
echo "modif 1" >> README.rst
git add README.rst
git commit -m "modif 1"
git push
git checkout master
git pull --all
git merge --no-ff develop
git push
git tag V1
git push origin V1
git checkout develop
echo "modif 2" >> README.rst
git add README.rst
git commit -m "modif 2"
git push
git checkout master
git pull --all
git merge --no-ff develop
git push
git tag V2
git push origin V2
git checkout develop
git commit -m "commit 10" --allow-empty
git commit -m "commit 11" --allow-empty
git commit -m "commit 12" --allow-empty
git commit -m "commit 13" --allow-empty
git commit -m "commit 14" --allow-empty
git commit -m "commit 15" --allow-empty
git commit -m "commit 16" --allow-empty
git commit -m "commit 17" --allow-empty
git commit -m "commit 18" --allow-empty
git commit -m "commit 19" --allow-empty
git commit -m "commit 20" --allow-empty
git commit -m "commit 21" --allow-empty
git commit -m "commit 22" --allow-empty
git commit -m "commit 23" --allow-empty
git commit -m "commit 24" --allow-empty
git commit -m "commit 25" --allow-empty
git commit -m "commit 26" --allow-empty
git commit -m "commit 27" --allow-empty
git commit -m "commit 28" --allow-empty
git commit -m "commit 29" --allow-empty
git commit -m "commit 30" --allow-empty
git commit -m "commit 31" --allow-empty
git commit -m "commit 32" --allow-empty
git commit -m "commit 33" --allow-empty
git commit -m "commit 34" --allow-empty
git commit -m "commit 35" --allow-empty
git commit -m "commit 36" --allow-empty
git commit -m "commit 37" --allow-empty
git commit -m "commit 38" --allow-empty
git commit -m "commit 39" --allow-empty
git commit -m "commit 40" --allow-empty
git commit -m "commit 41" --allow-empty
git commit -m "commit 42" --allow-empty
git commit -m "commit 43" --allow-empty
git commit -m "commit 44" --allow-empty
git commit -m "commit 45" --allow-empty
git commit -m "commit 46" --allow-empty
git commit -m "commit 47" --allow-empty
git commit -m "commit 48" --allow-empty
git commit -m "commit 49" --allow-empty
git commit -m "commit 50" --allow-empty
git commit -m "commit 51" --allow-empty
git commit -m "commit 52" --allow-empty
git commit -m "commit 53" --allow-empty
git commit -m "commit 54" --allow-empty
git commit -m "commit 55" --allow-empty
git commit -m "commit 56" --allow-empty
git commit -m "commit 57" --allow-empty
git commit -m "commit 58" --allow-empty
git commit -m "commit 59" --allow-empty
git push