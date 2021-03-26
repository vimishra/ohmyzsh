# First determine my os
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
fi

# Realpath
alias rp="readlink -f "

# grep for running process, like: 'any vim'
any() {
    emulate -L zsh
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any <keyword>" >&2 ; return 1
    else
        local STRING=$1
        local LENGTH=$(expr length $STRING)
        local FIRSCHAR=$(echo $(expr substr $STRING 1 1))
        local REST=$(echo $(expr substr $STRING 2 $LENGTH))
        ps xauwww| grep "[$FIRSCHAR]$REST"
    fi
}

## Pipe Aliases (Global)
alias -g L='|less'
alias -g G='|grep'
alias -g T='|tail'
alias -g H='|head'
alias -g W='|wc -l'
alias -g S='|sort'

# Set and unset the proxy servers.
function proxyon(){
    export http_proxy="http://proxy-iind.intel.com:911"
    export https_proxy="http://proxy-iind.intel.com:911"
    export ftp_proxy="http://proxy-iind.intel.com:911"
    export socks_proxy="http://proxy-iind.intel.com:1080"
    # export ALL_PROXY='socks5://proxy-iind.intel.com:1080'
    export no_proxy="intel.com,.intel.com,10.0.0.0/8,192.168.0.0/16,localhost,127,0.0.1,127.0.0.0/8,134.134.0.0/16"
    # echo -e "\nProxy environment variable set."
}
function proxyoff(){
    unset HTTP_PROXY
    unset http_proxy
    unset HTTPS_PROXY
    unset https_proxy
    unset FTP_PROXY
    unset ftp_proxy
    unset socks_proxy
    unset ALL_PROXY
    unset no_proxy
    # echo -e "\nProxy environment variable removed."
}
#proxyon

function jpt(){
    # Fires-up a Jupyter notebook by supplying a specific port
    jupyter notebook --no-browser --port=$1
}

function jptt(){
    # Forwards port $1 into port $2 and listens to it
    ssh -N -f -L localhost:$2:localhost:$1 vikasm@192.168.1.19
}

alias port_forward='nohup ssh -N -f -L localhost:8890:localhost:8890 vikasm@192.168.1.225'
alias remote_notebook_start_tf='nohup ssh -f vikasm@192.168.1.225 ". /home/vikasm/anaconda3/etc/profile.d/conda.sh; conda activate tensorflow; jupyter lab --no-browser --port=8890"; port_forward'
alias remote_notebook_start_torch='nohup ssh -f vikasm@192.168.1.225 ". /home/vikasm/anaconda3/etc/profile.d/conda.sh; conda activate torch; jupyter lab --no-browser --port=8890"; port_forward'
alias remote_notebook_stop='ssh vikasm@192.168.1.225 "pkill -u vikasm jupyter"'

# A few aliases for exa, a ls replacement
alias l="exa --sort Name --classify"
alias lb="exa --sort size --long --classify --reverse"
alias ll="exa --sort Name --long --classify"
alias la="exa --sort Name --long --classify --all"
alias lr="exa --sort Name --long --classify --recurse"
alias lra="exa --sort Name --long --classify --recurse --all"
alias lt="exa --sort Name --long --tree --classify"
alias lta="exa --sort Name --long --tree --all --classify"
alias ls="exa --sort Name --classify"
alias lrt="exa --long -snew"


# Local Variables:
# mode:shell-script
# sh-shell:zsh
# End:
