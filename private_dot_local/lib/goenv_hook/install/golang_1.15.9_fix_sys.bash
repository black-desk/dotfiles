#!/bin/env bash
if [[ $SCRIPT_DEBUG ]]; then
        set -x
fi

if [[ "$DEFINITION" != '1.15.9' ]]; then
        return
fi

if [[ -z $GOENV_GOPATH_PREFIX ]]; then
        prefix=$HOME/go
else
        prefix=$GOENV_GOPATH_PREFIX
fi

OLD_GOPATH=$GOPATH
OLD_GO111MODULE=$GO111MODULE
export GO111MODULE=off
export GOPATH=$prefix/1.15.9
sys_version=$(git -C "$GOPATH"/src/golang.org/x/sys rev-parse HEAD \
        2>/dev/null || true)
if [[ $sys_version != 27713097b9563e84e4e03a2ed9652ef9fe62263a ]]; then
        echo "start fix golang.org/x/sys for go 1.15.9"
        go get -v -d golang.org/x/sys/...
        git -C "$GOPATH"/src/golang.org/x/sys reset --hard \
                27713097b9563e84e4e03a2ed9652ef9fe62263a
        echo "start fix golang.org/x/sys for go 1.15.9 ...done"
fi
export GOPATH=$OLD_GOPATH
export GO111MODULE=$OLD_GO111MODULE
