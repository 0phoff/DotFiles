# 0phoff's Personal DotFiles
This repo contains my personal dotfiles.  
Feel free to look around, copy and redistribute at your own will!  
I would not recomend blindly taking over my dotfiles, as they contain quite a lot of aliasses, vim mappings, etc. It is always better to build your own dotfiles!

## Different Files Explained
Like a lot of people, I keep all my dotfiles in a separate folder, and create symlink at the places where they should be.  

	- Bash/ : In this directory you can find my bashrc as well as other scripts I source or link to /usr/local/bin
	- Tmux/ : This folder contains my tmux configuration
	- Vim/	: This folder contains my Vim configuration. I use neovim, so that's a thing to consider...

## TODO
Creating and maintaining dotfiles is an endless torture, so here is a small todo-list for myself

### Vim
##### Settings
	- Use std completion
		+ [ ] automatic popup after X letters are typed and there are less then Y possible completions
		+ [ ] ctrl-x = toggle completion mode
		+ [ ] ctrl-p/f/... stay in completion mode
##### Markdown
	- Change md syntax
		+ [ ] # be yellow
##### C/C++
	- Remove angle brackets from ClosePair.vim

### Tmux
##### Settings
	- Customize powerline
##### Packages
	- Tmuxinator (or other session saver)

### Random  
	- Fix documents created in Linux -> chmod

