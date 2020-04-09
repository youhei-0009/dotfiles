#!/bin/bash -eu

echo ------------------------------------------------
echo                     dotfiles
echo ------------------------------------------------

cd ~/dotfiles

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ".gitmodules" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue

  ln -sf ~/dotfiles/$f ~/$f
done
