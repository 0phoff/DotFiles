# 0phoff's Personal DotFiles
This repo contains my personal dotfiles.  
Feel free to look around, copy and redistribute at your own will!  
I would not recomend blindly taking over my dotfiles, as they contain quite a lot of aliasses, vim mappings, etc. It is always better to build your own dotfiles!

## Different Files Explained
Like a lot of people, I keep all my dotfiles in a separate folder, and create symlink at the places where they should be.  

	- Bash/ : In this directory you can find my bashrc as well as other small scripts I either source in my bashrc or symlink to /usr/bin to be able to execute
	- Tmux/ : This folder contains my tmux configuration
	- Vim/	: This folder contains my Vim configuration. I use neovim, so that's a thing to consider...

## TODO
Creating and maintaining dotfiles is an endless torture, so here is a small todo-list for myself

### Vim
#### Settings
	- Use std completion
		+ [ ] automatic popup after X letters are typed and there are less then Y possible completions
		+ [ ] ctrl-x = toggle completion mode
	        + [ ] ctrl-p/f/... stay in completion mode
#### FileType Specific
##### Markdown
	- Change md syntax
		+ [ ] # be yellow
##### C
	- Remove angle brackets from ClosePair.vim

### Tmux
#### Settings
	- Customize powerline
#### Packages
	- Tmuxinator (or other session saver)
### Patch Font
	- patch with indentLines

### Random  
	- Fix documents created in Linux -> chmod
