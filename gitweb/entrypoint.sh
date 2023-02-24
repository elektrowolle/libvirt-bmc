#!/bin/sh

git init --bare /var/lib/git/infra.git -b main
chmod -R 7777 /var/lib/git/infra.git
git --git-dir=/var/lib/git/infra.git config --add http.uploadpack true
git --git-dir=/var/lib/git/infra.git config --add http.receivepack true
git --git-dir=/var/lib/git/infra.git config --add http.getanyfile true

httpd -DFOREGROUND $@
