#!/bin/env bash

if [[ $SCRIPT_DEBUG ]]; then
	set -x
fi

pwd=$PWD

while [[ ! -f ./.goenvrc ]] && [[ $PWD != / ]]; do
        cd ..
done

if [[ -f ./.goenvrc ]]; then
        source ./.goenvrc || exit 255
fi


cd "$pwd" || exit 255
