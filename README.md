## Dotfiles
My dotfiles for neovim, tmux, kitty and fish shell.

**Note that this project is not actively maintained as I am using [Nix home-manager](https://github.com/nix-community/home-manager) to manage my dotfiles.**

*Prerequisites*: 
1. `stow` command line tool. 
2. [Neovim](https://neovim.io/)
3. [Tmux](https://github.com/tmux/tmux/wiki)
4. [Fish](https://fishshell.com/)
5. [Kitty](https://sw.kovidgoyal.net/kitty/)

*Steps*: 
1. Clone the project to your home directory and `cd` into the project.
2. `stow` the corresponding configuration of interest. For example
```bash
stow tmux/ # for tmux
stow nvim/ # for nvim
stow kitty/ # for kitty
stow fish/ # for fish
# or
stow */ # for all configurations
```
