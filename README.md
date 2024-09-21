
# thefly

<img align=left width="150px" src="https://github.com/user-attachments/assets/a537f833-a64f-40b0-99a3-fff9cca08ce8">

<br/>
bash/zsh/ksh plugin manager and env teleporter  

Your shell env and plugins are available everywhere (hosts/users)  
&nbsp;  
bzzz bzzz!  
<br/>  
## Install
```
. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) install
```
or
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
will clone `https://github.com/joknarf/redo` in `~/.fly.d/plugins/redo`  
all plugins in `~/fly.d/plugins/*/*.plugin.<shell>` will be sourced at login

## Teleport plugins

* To another user
```
$ fsudo <user>
```
will duplicate `~/.fly.d` (without dot files/tests) in `/tmp/.fly.<user>/<flyid>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
`fsudob` (bash) - `fsudoz` (zsh) - `fsudok` (ksh)

* To another host/user
```
$ fssh <user>@<host>
```
will duplicate `~/.fly.d` (without dot files/tests) in `<host>:/tmp/.fly.<user>/<flyid>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
`fsshb` (bash) - `fsshz` (zsh) - `fsshk` (ksh)

* To another shell  
When connected with a shell change shell and load your env/plugins:  
`fbash` - `fzsh` - `fksh`
 
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

## Don't transform your fly in a MONSTER !

Remember that ~/.fly.d directory will be duplicated in /tmp, don't put huge data in your ~/.fly.d directory, the consequences could be huge ! (ask Jeff G. ;-)

Bzzz Bzzz
