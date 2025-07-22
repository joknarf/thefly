[![bash](https://img.shields.io/badge/shell-bash%20|%20zsh%20|%20ksh%20-blue.svg)]()
[![bash](https://img.shields.io/badge/OS-Linux%20|%20macOS%20|%20SunOS%20...-blue.svg)]()

# thefly

<img align=left width="150px" src="https://github.com/user-attachments/assets/a537f833-a64f-40b0-99a3-fff9cca08ce8">

<br/>
bash/zsh/ksh plugin manager and env teleporter  

Your shell env and plugins are available everywhere (hosts/users)  
&nbsp;  
bzzz bzzz !  
<br/>  

## Demo
![thefly_bzz](https://github.com/user-attachments/assets/1617632b-db08-40d4-a845-841e8ee5c7c6)


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
Get some help
```
fly help
```
## Add plugins

```
fly add joknarf/redo
```
clones `https://github.com/joknarf/redo` in `~/.fly.d/plugins/redo` and sources the `plugin.<shell>`  
(all plugins in `~/fly.d/plugins/*/*.plugin.<shell>` will be sourced at login with `fly source` in your shell rc file)

## Teleport plugins/shell env

* To another user on current host
```
$ flyas <user>
or
$ fsu <user>
```
will duplicate `~/.fly.d` (without cvs files/tests) in `/tmp/.fly.<user>/<flyid>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
`fsub` or `bsu` (bash) - `fsuz` or `zsu` (zsh) - `fsuk` or `ksu` (ksh)

* To another host/user
```
$ flyto [<ssh opts>] <user>[<@host>]
or
$ fssh [<ssh opts>] <user>[<@host>]
```
will duplicate `~/.fly.d` (without cvs files/tests) in `<host>:/tmp/.fly.<user>/<flyid>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
`fsshb` or `bto` (bash) - `fsshz` or `zto` (zsh) - `fsshk` or `kto` (ksh)  
 
* To another shell  
Change current shell and load your env/plugins:  
`$ flysh <shell> # shell in bash ksh zsh`  
or `fbash` - `fzsh` - `fksh`  

 
## Customize env

Putting your env in `~/.fly.d/.flyrc` will be automatically sourced (must be compatible with different shells)  
Putting additional shell specific env in `~/.fly.d/.<shellname>rc` (.bashrc/.kshrc/.zshrc), will be automatically sourced for shell.

anything in `~.fly.d` will be available through ssh/sudo (flyto/flyas) in `$FLY_HOME/.fly.d`  
For example, just put your `.vimrc` in `~/.fly.d` and add in `~/.fly.d/.flyrc`:
```
export VIMINIT="source $FLY_HOME/.fly.d/.vimrc"
```
same for `.inputrc`, put it in `~/.fly.d` and add in `~/.fly.d/.flyrc`:
```
export INPUTRC="$FLY_HOME/.fly.d/.inputrc"
```
You can crate a `.fly.d/bin` directory and put scripts you want to teleport and add in your `.fly.d/.flyrc`:
```
export PATH="$PATH:$FLY_HOME/.fly.d/bin"
```

## Create your standalone fly package with your full shell env/plugins

save your whole shell environment to use everywhere with standalone fly package.  
All your ~/.fly.d environment saved in autoextractable file. The fly package enables your env when sourced.
```
$ flypack >fly.pak
```
make your fly.pak available through url, to connect to a server with your env, use for example:
```
$ ssh -t <host> '. <(curl -s -L https://raw.githubusercontent.com/joknarf/flypack/main/fly.pak) [install] [bash|ksh|zsh]'
```
load your env in current user:
```
$ . <(curl -s -L https://raw.githubusercontent.com/joknarf/flypack/main/fly.pak) [install] [bash|ksh|zsh]
```

`install` option to install in user home dir `~/.fly.d`, default in `/tmp/.fly.$USER`


## Download/activate your env/plugins from your fly git repo or web server

put your .fly.d directory into a git repo and activate all your env/plugins in your current user
```
. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) install joknarf/myfly
```

create a tgz file with your .fly.d exposed on web server and activate env/plugins in your current user
```
. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) install https://myserver/myfly
```

## Connect using thefly env/plugins from http/git repo

uses user ~.fly.d to load env/plugins
```
$ ssh -t <user>@<host> '. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) remote'  
```

get env/plugins from .fly.d tgz (contains .fly.d/*)
```
$ ssh -t <user>@<host> '. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) remote <url .fly.d.tgz>'  
```

get env/plugins from github repository (repo contains .fly.d contents, and can contain plugins submodules)
```
$ ssh -t <user>@<host> '. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) remote <git owner/repo .fly.d>'  
```



## Set your joknarf cool plugins env

```
$ fly add joknarf/nerdp        # bash/ksh/zsh nerd prompt
$ fly add joknarf/seedee       # bash/ksh/zsh cd history
$ fly add joknarf/redo         # bash/zsh     command history
$ fly add joknarf/complete-ng  # bash/zsh     completion next-gen
or just add the optimized compilation of these shell plugins using just:
$ fly add joknarf/shell-ng

$ fly add joknarf/pgtree       # bash/ksh/zsh process hierarchy
```
|link                                                 |description                                                             |
|-----------------------------------------------------|------------------------------------------------------------------------|
|[nerdp](https://github.com/joknarf/nerdp)            |nerd dynamic customizable nice prompt                                   |
|[seedee](https://github.com/joknarf/seedee)          |access/search dir history with ctrl or shift down arrow, and many more  |
|[redo](https://github.com/joknarf/redo)              |access/search shell history command menu with shift-tab, and many more  |
|[complete-ng](https://github.com/joknarf/complete-ng)|autocompletion with interactive menu                                    |
|__[shell-ng](https://github.com/joknarf/shell-ng)__  |__optimized joknarf compilation of the above plugins__                  |
|[pgtree](https://github.com/joknarf/pgtree)          |process search / tree / kill command line                               | 

## Don't teleport a human with your fly !

Remember that ~/.fly.d directory will be duplicated in /tmp when teleporting, don't put huge data in your ~/.fly.d directory, the consequences could be dramatic ! (ask Jeff G. ;-)

Bzzz Bzzz
