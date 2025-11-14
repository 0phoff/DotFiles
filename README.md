![Logo](https://raw.githubusercontent.com/0phoff/dotfiles/master/logo.png)  

# 0phoff's DOT-files
This branch contains a basic set of dotfiles (bash, vim, git), that can easily be deployed using chezmoi.

## Install
The following snippet will install chezmoi and this set of configs.
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --branch mini --apply 0phoff 
```

The following snippet installs the configs with chezmoi and then removes all traces of chezmoi
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --branch mini --one-shot 0phoff 
```

> Do note that this script requires user inputs to setup a few of the values of my config.  
> If you want to use this config in a non-interactive environment (eg dockerfile), the `--promptDefaults` flag allows to accept default values.
> Alternatively, you can specify values with the flags `--promptBool`, `--promptString`, etc.

## Changing prompt values
This config uses `prompt*Once` functions, so that you only need to answer the prompt questions on the first init and not when updating the config.  
You can force `chezmoi` to re-prompt by using `chezmoi init --prompt`.
