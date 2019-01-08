#!/bin/bash
## -------------------------
# Bash options for prompt
# -------------------------

# COLORS
COLOR_NONE='\[\e[0;0m\]'
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
PURPLE='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
GRAY='\[\e[0;37m\]'
# BOLD
RED_B='\[\e[1;31m\]'
GREEN_B='\[\e[1;32m\]'
YELLOW_B='\[\e[1;33m\]'
BLUE_B='\[\e[1;34m\]'
PURPLE_B='\[\e[1;35m\]'
CYAN_B='\[\e[1;36m\]'
WHITE_B='\[\e[1;37m\]'

VENV_PREFIX="("
VENV_SUFFIX=")"

PYTHON_LOGO="\ue73c"
JS_LOGO="\ue74e"
USER_LOGO="\uf007"
DIR_LOGO="\ue5fe"
GIT_LOGO="\ue725"

_get_virtualenv_prompt() {
    if [ -n "$VIRTUAL_ENV" ]; then
        if [ -f "$VIRTUAL_ENV/__name__" ]; then
            local NAME=`cat $VIRTUAL_ENV/__name__`
        elif [ `basename $VIRTUAL_ENV` = "__" ]; then
            local NAME=$(basename $(dirname $VIRTUAL_ENV))
        else
            local NAME=$(basename $VIRTUAL_ENV)
        fi
        echo "${YELLOW_B}${VENV_PREFIX}$NAME${VENV_SUFFIX} "
    fi
}

_get_python_version() {
	local PY_VER=$(python --version 2>&1)
	echo "${YELLOW_B}$PYTHON_LOGO ${PY_VER:7}"
}

_get_nodejs_prompt() {
    if hash node 2>/dev/null; then
        local JS_VER=$(node -v)
    fi
    if [ "$JS_VER" != "" ]; then
        echo "${WHITE_B}${JS_LOGO} ${JS_VER:1}"
    fi
}

_get_git_prompt() {
	local GIT_STATUS=$(__git_ps1 "%s") 
	[ ! -z "$GIT_STATUS" ] && echo "${CYAN}$GIT_LOGO $GIT_STATUS  "
}

prompt_command() {
	PS1=$(echo -e "${PURPLE}${USER_LOGO} \u  $(_get_python_version) $(_get_virtualenv_prompt) $(_get_nodejs_prompt)  $(_get_git_prompt)${BLUE}$DIR_LOGO \w\n${GREEN_B}$\[\033[00m\] ")
}

# Set the prompt
PROMPT_COMMAND=prompt_command
