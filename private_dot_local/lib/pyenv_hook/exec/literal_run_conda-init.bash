#!/bin/env bash

if [[ $SCRIPT_DEBUG ]]; then
        set -x
fi

pyenv which conda &>/dev/null|| return 0

__conda_setup="$("$(pyenv which conda)" shell.bash hook 2> /dev/null)"
eval "$__conda_setup"
