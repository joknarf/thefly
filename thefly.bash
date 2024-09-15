: "${_fenvdir:=$HOME}"
case "$1" in
install|remote)
    unset _floaded
    mkdir -p "$_fenvdir/.flyrc.d"
    [ -f "$_fenvdir/.flyrc.d/.flyrc" ] || touch "$_fenvdir/.flyrc.d/.flyrc"
    _flycmd="tee $_fenvdir/.flyrc.d/thefly"
    ;;
*)  _flycmd="cat"
    ;;
esac

. <($_flycmd <<'EOFLY'
[ "$_floaded" ] && return
echo "the fly !!!"
_floaded=1
: "${_fenvdir:=$HOME}"
: "${_fgithub=https://github.com}"

function _fpackage
{
    (cd $_fenvdir && tar czf - --exclude-vcs .flyrc.d 2>/dev/null)
}

function _fxpackage
{
    printf %s 'umask 077;mkdir -p /tmp/.fly.$USER;cd /tmp/.fly.$USER;tar xzf -'
}

function _flogin
{
    typeset fenvd="$1"
    printf %s ". $fenvd/.flyrc.d/thefly;bash --init-file <(_flogin_rc $fenvd)"
}

function _fsource_plugins
{
    typeset p=${1:-*} plugin
    for plugin in $(ls $_fenvdir/.flyrc.d/$p/*.plugin.bash 2>/dev/null);do
        . $plugin
    done
}

function _fsource_profile
{
    \cd /;\cd
    alias typeset="typeset +r"
    alias readonly=typeset
    $_gprof && . /etc/profile
    $_uprof && for i in .bash_profile .bash_login .profile;do
        [ -r $i ] && . ./$i && break
    done
    unalias typeset
    unalias readonly
    unset _gprof _uprof
    [ -r $_fenvdir/.flyrc.d/.flyrc ] && . $_fenvdir/.flyrc.d/.flyrc
    _fsource_plugins
}

function _flogin_rc
{
    typeset fenvd="$1"
    printf '%s\n' '_gprof=true _uprof=true'
    printf '%s\n' "_fenvdir=$fenvd"
    printf '%s\n' '. $_fenvdir/.flyrc.d/thefly login'
}

function fsudo
{
    typeset user=${1:-root}
    _fpackage |sudo -H -u "$user" bash -c "$(_fxpackage)"
    sudo -H -u "$user" bash -c "$(_flogin '/tmp/.fly.$USER')"
}

function fssh2
{
    _fpackage | ssh "$@" "$(_fxpackage)"
    ssh "$@" -t "bash -c '$(_flogin)'"
}

function _fssh_cmd
{
    typeset destdir='/tmp/.fly.$USER' b64opt
    echo ok |base64 -w0 >/dev/null 2>&1 && b64opt='-w0'
    cat - <<EOF
umask 077
mkdir -p $destdir
! chmod 700 $destdir && echo "Not owner of $destdir. Abort" && exit 1
cd $destdir
echo $(_fpackage |base64 $b64opt) |base64 -d |tar xzf -
[ $? != 0 ] && echo "Unpack env failed. Abort." && exit 1
. ./.flyrc.d/thefly
exec bash --init-file <(_flogin_rc $destdir)
EOF
}

function fssh
{
    typeset ssh_config cmd
    for i in "$@";do
       [ $i = -F ] && shift && ssh_config="Include $1" && shift && continue
       shift
       set -- "$@" "$i"
    done
    [ ! "$ssh_config" ] && [ -f ~/.ssh/config ] && ssh_config="Include $HOME/.ssh/config"
    cmd="$(_fssh_cmd)"
    cmd="${cmd//$'\n'/;}"
    cat - <<EOF >$_fenvdir/.fly_ssh
$ssh_config
RemoteCommand $cmd
EOF
    ssh -t -F $_fenvdir/.fly_ssh "$@"
}

function fly_init
{
    mkdir -p $_fenvdir/.flyrc.d
}

function fly
{
    typeset plugin
    case "$1" in
    add)
        mkdir -p "$_fenvdir/.flyrc.d"
        (cd $_fenvdir/.flyrc.d && git clone "$_fgithub/$2")
        _fsource_plugins "${2#*/}"
    ;;
    update)
        (cd $_fenvdir/.flyrc.d/${2#*/} && git pull origin $(sed -e 's#.*/##' .git/HEAD))
        _fsource_plugins "${2#*/}"
    ;;
    list)
        ls -1 $_fenvdir/.flyrc.d/*/*.plugin.bash
    ;;
    source)
        _fsource_plugins
    ;;
    esac
}


# ssh -t xxx . <(curl -s http://xxx/thefly) --url http://xxx/thefly.tgz
[ "$1" = "--url" ] && {
    cd $_fenvdir
    curl -o ./.fly.pak -L "$2"
    tar tzvf .fly.pak |grep -qv ' .flyrc'
    [ $? = 0 ] && echo "not fly package" && return
    tar xzf .fly.pak
    . <(_flogin $_fenvdir)
}

[ "$1" = "--git" ] && {
    cd $_fenvdir
    git clone "$_fgithub/$3" .flyrc.d
    . <(_flogin $_fenvdir)
}

case "$1" in
    login) _fsource_profile;;
    source) _fsource_plugins;;
    remote) shift;. <(_flogin $_fenvdir);;
esac
:
EOFLY
)
: