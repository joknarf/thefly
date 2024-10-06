
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

## Add plugins

```
fly add joknarf/redo
```
clones `https://github.com/joknarf/redo` in `~/.fly.d/plugins/redo` and sources the `plugin.<shell>`
(all plugins in `~/fly.d/plugins/*/*.plugin.<shell>` will be sourced at login with `fly source` in your shell rc file)

## Teleport plugins

* To another user
```
$ fly as <user>
or
$ fsudo <user>
```
will duplicate `~/.fly.d` (without cvs files/tests) in `/tmp/.fly.<user>/<flyid>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
`fsudob` (bash) - `fsudoz` (zsh) - `fsudok` (ksh)

* To another host/user
```
$ flyto [<ssh opts>] <user>[<@host>]
or
$ fssh [<ssh opts>] <user>[<@host>]
```
will duplicate `~/.fly.d` (without cvs files/tests) in `<host>:/tmp/.fly.<user>/<flyid>/.fly.d` and source all plugins  
by default uses `<user>` shell, to force your favorite shell:  
`fsshb` (bash) - `fsshz` (zsh) - `fsshk` (ksh)

* To another shell  
Change current shell and load your env/plugins:  
`$ flysh <shell> # shell in bash ksh zsh`  
or  
`fbash` - `fzsh` - `fksh`  
 
## Customize env

Putting your env in `~/.fly.d/.flyrc` will be automatically sourced (must be compatible with different shells)  
Putting additional shell specific env in `~/.fly.d/.<shellname>rc` (.bashrc/.kshrc/.zshrc), will be automatically sourced for shell.

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

get env/plugins from github repository (repo contains .fly.d contents, cat contain plugins submodules)
```
$ ssh -t <user>@<host> '. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) remote <git owner/repo .fly.d>'  
```

## connect with full env from fly package

save/restore your whole environment everywhere
```
$ flypack >fly.pak
```
make your fly.pak available through url, then use for example:
```
ssh -t <host> '. <(curl -s -L https://raw.githubusercontent.com/joknarf/flypack/main/fly.pak)'
```

## Set your joknarf cool plugins env

```
$ fly add joknarf/nerdp        # bash/ksh/zsh nerd prompt
$ fly add joknarf/seedee       # bash/ksh/zsh cd history
$ fly add joknarf/redo         # bash/zsh     command history
$ fly add joknarf/complete-ng  # bash         completion next-gen
$ fly add joknarf/pgtree       # bash/ksh/zsh process hierarchy
```

## Don't teleport a human with your fly !

Remember that ~/.fly.d directory will be duplicated in /tmp when teleporting, don't put huge data in your ~/.fly.d directory, the consequences could be huge ! (ask Jeff G. ;-)

Bzzz Bzzz
