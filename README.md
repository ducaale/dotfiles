# Dotfiles

### requirement
- GNU Stow

### installation
```bash
$ git clone https://github.com/ducaale/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ stow neovim tmux
```

install neovim plugins with vim-plug
````bash
$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ nvim +PlugInstall +qa
`````

for more information check https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
