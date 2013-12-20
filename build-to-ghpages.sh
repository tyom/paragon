git co --orphan gh-pages
find . ! -path '*/\.git/*' ! -path '*/build/*' -delete
mv build/* .
rmdir build
git add . && git add -u
