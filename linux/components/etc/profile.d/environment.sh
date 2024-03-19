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

  # axel
  alias axel='axel --alternate'

  # git
  alias push='git push --set-upstream'
  alias log='git log --oneline'
  alias pull='git pull --rebase'
  alias commit='git add --all; git commit'
  alias st='git status --ignored'

  # alias expand watch
  alias watch='command watch '

  # gnu specifics
  alias time='command time -v '

  # python
  alias pip='pip3'
  alias python='python3'

  # x11
  alias open='xdg-open'

  # vim
  alias vi='vim'
  alias vim='vim -p'

fi

case "$TERM" in
  xterm-color|*-256color)
      color_prompt='\[\033[;32m\]'
      color_info='\[\033[1;34m\]'
      color_reset='\[\033[0m\]'
      color_regular_bold='\[\033[0;1m\]'
      prompt_symbol='@'
      ;;
  *)
      color_prompt=''
      color_info=''
      color_reset='\[\033[0m\]'
      color_regular_bold=''
      prompt_symbol='@'
      ;;
esac

PS1=$color_prompt'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+('$color_regular_bold'$(basename $VIRTUAL_ENV)'$color_prompt')}('$color_info'\u'$prompt_symbol'\h'$color_prompt')-['$color_regular_bold'\w'$color_prompt']\n'$color_prompt'└─'$color_info'\$'$color_reset' '

unset color_prompt color_info color_reset prompt_symbol
