# thefly

bash plugin manager teleporter  
Your shell plugins are available everywhere (hosts/users)

## Install

```
$ git clone https://github.com/joknarf/thefly
$ . thefly/thefly.bash install
```
Creates ~/.flyrc.d/thefly

Add in your rc file (.profile .bash_profile .bashrc):
```
. ~/.flyrc.d/thefly source
```

## Add plugin

```
fly add joknarf/redo
```
will clone `https://github.com/joknarf/redo` in `~/.flyrc.d/redo`  
all plugins in `~/flyrc.d/*/*.plugin.bash` will be sourced at login

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
will duplicate `~/.flyrc.d` in `<host>:/tmp/.fly.<user>` and source all plugins

## Customize env

Putting your env in `~/.flyrc.d/.flyrc` will be automatically sourced

## Connect using thefly from http

```
$ ssh -t <user>@<host> '. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly.bash) remote'  
```

## Connect and download .flyrc.d plugins from git repository

```
$ ssh -h <user>@<host> ''. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly.bash) --git joknarf/myflyrc'  
```