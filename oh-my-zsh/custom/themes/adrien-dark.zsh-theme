# vim:ft=zsh ts=2 sw=2 sts=2

[ $UID -eq 0 ] && NCOLOR="red" || NCOLOR="yellow"

# See http://geoff.greer.fm/lscolors/
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[082]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[166]%}✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%}✭%{$reset_color%}"

#PROMPT_RC="%(?.%{$fg[green]%}✔.%{$fg[red]%}✘)%{$reset_color%} "
PROMPT_RC="%(?..%{$fg[red]%}✘) "
PROMPT_GIT='$(git_prompt_status)%{$GIT_PROMPT_INFO%}%{$FG[012]%}$(git_prompt_info) '
PROMPT_TIME="%{$FG[000]%}%D{%H:%M}"

PROMPT="%{$fg[$NCOLOR]%}➤ %c ➤%{$reset_color%} "
RPROMPT="${PROMPT_RC}${PROMPT_GIT}${PROMPT_TIME}%{$reset_color%}"
