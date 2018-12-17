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
NODEJS_LOGO="\ue74e"
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
        echo " ${YELLOW_B}${VENV_PREFIX}$NAME${VENV_SUFFIX}"
    fi
}

_get_python_version() {
	local PY_VER=$(python --version 2>&1)
	echo "${YELLOW_B}$PYTHON_LOGO ${PY_VER:7}"
}

_get_nodejs_prompt() {
    if hash node 2>/dev/null; then
        local NAME=$(node -v)
    fi
    if [ "$NAME" != "" ]; then
        echo "${RED}${NODEJS_LOGO} ${NAME:1}"
    fi
}

_get_git_prompt() {
	local NAME=$(__git_ps1 "$GIT_LOGO %s")
	echo " ${CYAN}${NAME/\$/}"
}

python_interpreter_like_prompt() {
	PS1=$(echo -e "${GREEN_B}${USER_LOGO} \u  $(_get_python_version)$(_get_virtualenv_prompt) $(_get_nodejs_prompt)  ${BLUE_B}$DIR_LOGO \w $(_get_git_prompt)\n${GREEN_B}$\[\033[00m\] ")
}

# Set the prompt
PROMPT_COMMAND=python_interpreter_like_prompt
