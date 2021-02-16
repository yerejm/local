PROMPT='[%*] %{$fg[green]%}%n%{$reset_color%}%{$fg[red]%}@%{$reset_color%}%{$fg[yellow]%}%m%{$reset_color%}:%~ $(hg_prompt_info)$(git_prompt_info)%{$reset_color%}
%# '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}git:(%{$reset_color%}%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%})"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[green]%}hg:(%{$reset_color%}%{$fg[red]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[green]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[green]%})"
