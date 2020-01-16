##################################################
#
# Environment Shell Initialisation
# https://github.com/ashenm/environment
#
# Ashen Gunaratne
# mail@ashenm.ml
#
##################################################

# set editor
export EDITOR=vim

# directory listing
alias l='ls -C'
alias la='ls -A'
alias ll='ls -Al'
alias ls='ls --classify --color=auto'

# if not root
if [ `id -u` -ne 0 ]
then

  # defult 700
  umask 0077

  # protect user
  alias cp='cp -i'
  alias mv='mv -i'
  alias rm='rm -i'

  # git
  alias push='git push'
  alias log='git log --oneline'
  alias pull='git pull --rebase'
  alias commit='git add --all; git commit'
  alias st='git status --ignored'

  # gnu
  alias time='command time -v'

  # python
  alias pip='pip3'
  alias python='python3'

  # vim
  alias vi='vim'
  alias vim='vim -p'

fi
