# thefly

bash/zsh/ksh plugin manager teleporter  
Your shell plugins are available everywhere (hosts/users)

## Install

```
$ git clone https://github.com/joknarf/thefly
$ . thefly/thefly install
```
Creates ~/.flyrc.d/thefly

Add in your rc file (.profile .bash_profile .bashrc .zshrc):
```
. ~/.flyrc.d/thefly source
```

## Add plugins

```
fly add joknarf/redo
```
will clone `https://github.com/joknarf/redo` in `~/.flyrc.d/redo`  
all plugins in `~/flyrc.d/*/*.plugin.<shell>` will be sourced at login

## Teleport plugins

* To another user
```
$ fsudo <user>
```
will duplicate `~/.flyrc.d` in `/tmp/.fly.<user>/.flyrc.d` and source all plugins

* To another host/user
```
$ fssh <user>@<host>
```
will duplicate `~/.flyrc.d` in `<host>:/tmp/.fly.<user>/.flyrc.d` and source all plugins

## Customize env

Putting your env in `~/.flyrc.d/.flyrc` will be automatically sourced (must be compatible with different shells)
Putting additional env in `~/.flyrc.d/.flyrc.<shell>` will be automically sourced for shell

## Connect using thefly from http

```
$ ssh -t <user>@<host> '. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) loginshell'  
```

## Connect and download .flyrc.d plugins from a git repository

```
$ ssh -h <user>@<host> ''. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) --git joknarf/myflyrc'  
```