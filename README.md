[![Joknarf Tools](https://img.shields.io/badge/Joknarf%20Tools-Visit-darkgreen?logo=github)](https://joknarf.github.io/joknarf-tools)
[![Build and Release Packages](https://github.com/joknarf/thefly/actions/workflows/release.yml/badge.svg)](https://github.com/joknarf/thefly/actions/workflows/release.yml)
[![Shell](https://img.shields.io/badge/shell-bash%20|%20zsh%20|%20ksh%20-blue.svg)]()
[![OS](https://img.shields.io/badge/OS-Linux%20|%20macOS%20|%20SunOS%20...-blue.svg)]()
[![Licence](https://img.shields.io/badge/licence-MIT-blue.svg)](https://shields.io/)
[![Packages](https://img.shields.io/badge/Packages-%20rpm%20|%20deb%20|%20pkg%20|%20apk%20|%20brew%20-darkgreen.svg)](https://github.com/joknarf/thefly/releases/latest)

# thefly

<img align=left width="150px" src="https://github.com/user-attachments/assets/a537f833-a64f-40b0-99a3-fff9cca08ce8">

<br/>
bash/zsh/ksh plugin/dotfiles manager and teleporter  

Your shell env and plugins are available everywhere (hosts/users)  

bzzz bzzz !  

<br/>  

What the point to have a fine tuned local shell environment if you lose it as soon as you connect to another server / sudo to another user

## Demo
![thefly_bzz](https://github.com/user-attachments/assets/1617632b-db08-40d4-a845-841e8ee5c7c6)

## features

Keep your full shell environment anywhere you go.

* supports bash / zsh / ksh (on Linux / MacOS / ...)
* multi-shell plugin manager to install / update / uninstall shell plugins
* multi-shell dotfiles manager
* teleport dotfiles and plugins through sudo (`flyas`)
* teleport dotfiles and plugins through ssh (`flyto`)
* force specific destination shell when sudo or ssh (not using target user shell)
* create a single pak env file including dotfiles and plugins to be used anywhere (`flypack >pak`, `. ./pak`)
  
## Install
```
. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) install
```
or
```
git clone https://github.com/joknarf/thefly
. thefly/thefly install
```
Creates ~/.fly.d/fly and activate thefly manager for current user


or use your prefered method according to your OS:

```
brew install joknarf/tools/thefly
```

```
sudo dnf install https://github.com/joknarf/thefly/releases/latest/download/thefly.rpm
```

```
curl -OL https://github.com/joknarf/thefly/releases/latest/download/thefly.deb
sudo dpkg -i thefly.deb
```

```
curl -OL https://github.com/joknarf/thefly/releases/latest/download/thefly.apk
sudo apk add --allow-untrusted thefly.apk
```

```
curl -OL https://github.com/joknarf/thefly/releases/latest/download/thefly.pkg
sudo installer -pkg thefly.pkg -target /
```

then run:
```
thefly install
. ~/.fly.d/activate
```

Add in your rc file (.profile .bash_profile .bashrc .zshrc):
```
. ~/.fly.d/fly source
```
Get some help
```
fly help
```
## Plugins management

* add plugin
```
fly add joknarf/redo
```
clones `https://github.com/joknarf/redo` in `~/.fly.d/plugins/redo` and sources the `plugin.<shell>`  

(all plugins in `~/fly.d/plugins/*/*.plugin.<shell>` will be sourced at login with `fly source` in your shell rc file)

* update plugin
```
fly update [plugin]
```

* remove plugin
```
fly del [plugin]
```

* update user fly
```
fly upgrade
```

## Teleport plugins/shell env

thefly is able to duplicate your .fly.d directory through sudo and ssh to login with your full environment.

When teleporting the .fly.d is duplicated (without cvs files/tests) in :
```
/tmp/.fly.$USER/<id>/.fly.d
```
files are owned by target user, `$FLY_HOME` is set to `/tmp/.fly.$USER/<id>`

You can use all teleport method multiple times (`flyto host` then `flyas user`...)

### To another user

sudo login interactive shell to another user with your env
(current user need to have sudo privilege to target user)

```
$ flyas <user> [shell]
or
$ fsu <user> [shell]
```
By default uses `<user>`'s shell.

### To another host

ssh connect with interactive shell to another host with your env
```
$ flyto [<ssh opts>] <user>[<@host>]
or
$ fssh [<ssh opts>] <user>[<@host>]
```

by default uses `<user>` shell, to force your favorite shell use `fsshb` (bash) - `fsshz` (zsh) - `fsshk` (ksh)

### To another shell

Change current shell and load your env/plugins :  
```
$ flysh <shell> # shell in bash ksh zsh
```
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
You can create a `.fly.d/bin` directory and put scripts you want to teleport and add in your `.fly.d/.flyrc`:
```
export PATH="$PATH:$FLY_HOME/.fly.d/bin"
```

## Standalone fly package 

Save your whole shell environment to use everywhere with standalone fly package.

All your ~/.fly.d environment saved in autoextractable file. The fly package enables your env when sourced.

Build your fly package (you can copy and use it directly to get your env or make it available on web server to remote download)  
```
flypack >fly.pak
```
Then use your fly.pak anywhere :

`. ./fly.pak` : to activate your environment (in `/tmp/.fly.$USER`)

`. ./fly.pak install` : to extract in ~/.fly.d and activate

To activate from url:
```
. <(curl -sL https://raw.githubusercontent.com/joknarf/flypack/main/fly.pak)
```
to connect to a server with your env in `/tmp/.fly.$USER`, your can use:
```
$ ssh -t <host> '. <(curl -sL https://raw.githubusercontent.com/joknarf/flypack/main/fly.pak) [bash|ksh|zsh]'
```
Connect to all servers with your fly pak from url with ssh config:
```
RequestTTY yes
RemoteCommand . <(curl -sL https://raw.githubusercontent.com/joknarf/flypack/main/fly.pak)
```

## Activate from git repo or url

put your .fly.d directory into a git repo and activate all your env/plugins in your current user
```
. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) install joknarf/myfly
```

create a tgz file with your .fly.d exposed on web server and activate env/plugins in your current user
```
. <(curl https://raw.githubusercontent.com/joknarf/thefly/main/thefly) install https://myserver/myfly.tgz
```

## joknarf cool plugins

```
$ fly add joknarf/nerdp        # bash/ksh/zsh nerd prompt
$ fly add joknarf/seedee       # bash/ksh/zsh cd history
$ fly add joknarf/redo         # bash/zsh     command history
$ fly add joknarf/complete-ng  # bash/zsh     completion next-gen
or just add the optimized compilation of these shell plugins using just:
$ fly add joknarf/shell-ng

$ fly add joknarf/pgtree       # bash/ksh/zsh process hierarchy
$ fly add joknarf/lsicon       # ls enhancer (colors/icons)
$ fly add joknarf/dfbar        # df enhancer (colors/usage bar)
```

|link                                                 |description                                                             |
|-----------------------------------------------------|------------------------------------------------------------------------|
|[nerdp](https://github.com/joknarf/nerdp)            |nerd dynamic customizable nice prompt                                   |
|[seedee](https://github.com/joknarf/seedee)          |access/search dir history with ctrl or shift down arrow, and many more  |
|[redo](https://github.com/joknarf/redo)              |access/search shell history command menu with shift-tab, and many more  |
|[complete-ng](https://github.com/joknarf/complete-ng)|autocompletion with interactive menu                                    |
|__[shell-ng](https://github.com/joknarf/shell-ng)__  |__optimized joknarf compilation of the above plugins__                  |
|[pgtree](https://github.com/joknarf/pgtree)          |process search / tree / kill command line                               | 
|[lsicon](https://github.com/joknarf/lsicon)          |ls command enhancer (colors/icons)                                      | 
|[dfbar](https://github.com/joknarf/dfbar)            |df command enhancer (colors/usage bar)                                  | 

## Don't teleport a human with your fly !

Remember that ~/.fly.d directory will be duplicated in /tmp when teleporting, don't put huge data in your ~/.fly.d directory, the consequences could be dramatic ! (ask Jeff G. ;-)

Bzzz Bzzz
