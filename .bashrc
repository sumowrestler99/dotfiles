#!/bin/bash
export VIMRUNTIME=$HOME/usr/vim/runtime
#set language to utf8 - used by putty to display unicode characters
if [ "$TERM" == "putty-256color" ]; then
	export LANG=en_US.UTF-8
fi

# latest ca certs for curl
#export CURL_CA_BUNDLE=/home/ls400966/linux/var/cert/cacert.pem
version="${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}"
#default permission for new files
umask 022

export PATH=":$HOME/.local/bin$HOME/linux/bin:$HOME/linux/bin64:$HOME/bin:/tools/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin/X11:/usr/openwin/bin:~swuser/bin/bin:$HOME/.local/bin:$HOME/PathPicker:$HOME/.gem/bin"
export LD_LIBRARY_PATH=$HOME/linux/lib64:$HOME/linux/lib:/scratch/sjc-dsa/lsiao/toolchain/lib:/scratch/sjc-dsa/lsiao/toolchain/lib64:$LD_LIBRARY_PATH
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem
PROJ_PATH=/projects/slxos_dev/ls400966/slx/
#on setview, go directly to fabos/src directory
if [ "$PS1" != "" ] && [ -z $ENVONLY ] ; then
	export EDITOR=nvim
	export CDPATH=.:$PROJ_PATH/slxos_main/fabos/src:$PROJ_PATH/slxos_main/fabos/src/sys/lib:$PROJ_PATH/slxos_main/fabos/src/lp/dce:$HOME/load/data
	#needed by vim to enable python 2.7 scripts
	#export PYTHONPATH="/users/home23/lsiao/linux/lib/python2.7/site-packages:/users/home23/lsiao/linux/lib/python2.7"
	export PYTHONPATH=

	#enable color in ls
	COLORLS=1
	if [ -f ~/.bash-alias ]; then
		source ~/.bash-alias
	fi
	if [ -f ~/.bash-func ]; then
		source ~/.bash-func
	fi

	if [[ $version > "3.99" ]]; then
		shopt -s globstar #enable ** globbing bash 4 only
	fi
	if [[ $version > "4.0" ]]; then
		shopt -s autocd  #type directory name, automatically cd to it
	fi

	if [ ! -z "$TMUX" ]; then
		if [[ ! -o vi ]]; then
			# bind '"\er": redraw-current-line'
			# bind '"\e^": history-expand-line'

			bind '"\C-h": " \C-e\C-u`__fzf_concmd_list__`\e\C-e\er\e^\C-m"'
			bind '"\C-k": " \C-e\C-u`__fzf_telcmd_list__`\e\C-e\er\e^\C-m"'
		fi
	fi
fi
export PS1='\[\e[4;34m\]\h\[\e[0m\]\[\e[1;34m\]:`gwd` \[\e[0m\]\[\e[1;31m\](\!)\[\e[0m\] '
#export PS1="$PS1"'$([ -n "$TMUX" ] && eval $(tmux switch-client \; show-environment -s 2> /dev/null ))'
#export PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#D" 2> /dev/null | tr -d %) `pwd`)'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/bin/onieinst_complete.sh ] && source ~/bin/onieinst_complete.sh

#gpg-agent is mostly used as daemon to request and cache the password for the keychain
envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
	eval "$(cat "$envfile")"
else
	eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
fi

export GPG_AGENT_INFO  # the env file does not contain the export statement
export SSH_AUTH_SOCK   # enable gpg-agent for ssh

#bash completion
[ -f ~/linux/etc/profile.d/bash_completion.sh ] && . ~/linux/etc/profile.d/bash_completion.sh
# git completion
[ -f ~/git-completion.bash ] && . ~/git-completion.bash

export OPENGROK_SERVER=http://10.59.132.222:8080/slxos/
export MY_BUILD=$USER/slx/slxos_main
export MY_VSLX_BUILD=/slxos_dev/ls400966/slx/slxos_main/build/dist/mpls/
export LATEST_BUILD=daily/18.1.00/LATEST_BUILD
