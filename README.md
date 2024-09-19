# thefly

bash/zsh/ksh plugin manager teleporter  
Your shell plugins are available everywhere (hosts/users)

## Install

```
$ git clone https://github.com/joknarf/thefly
$ . thefly/thefly install
```
Creates ~/.fly.d/fly

Add in your rc file (.profile .bash_profile .bashrc .zshrc):
```
. ~/.fly.d/fly source
```

## Add plugins

```
fly add joknarf/redo
```
will clone `https://github.com/joknarf/redo` in `~/.fly.d/redo`  
all plugins in `~/fly.d/*/*.plugin.<shell>` will be sourced at login

## Teleport plugins

* To another user
```
$ fsudo <user>
```
will duplicate `~/.fly.d` in `/tmp/.fly.<user>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
fsudob (bash) - fsudoz (zsh) - fsudok (ksh)

* To another host/user
```
$ fssh <user>@<host>
```
will duplicate `~/.fly.d` in `<host>:/tmp/.fly.<user>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
fsshb (bash) - fsshz (zsh) - fsshk (ksh)

## Customize env

Putting your env in `~/.fly.d/.flyrc` will be automatically sourced (must be compatible with different shells)  
Putting additional env in `~/.fly.d/.flyrc.<shell>` will be automically sourced for shell

## Connect using thefly from http

```
$ ssh -t <user>@<host> '. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) loginshell'  
```

## Connect and download .fly.d plugins from a git repository

```
$ ssh -h <user>@<host> ''. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) --git joknarf/myflyrc'  
```