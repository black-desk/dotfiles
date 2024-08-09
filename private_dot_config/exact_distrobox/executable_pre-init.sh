#!/bin/sh

OS_NAME="$(awk -F= '/^NAME=/ { print $2 }' /etc/os-release)"
OS_VERSION_CODENAME="$(awk -F= '/^VERSION_CODENAME=/ { print $2 }' /etc/os-release)"

if [ "$OS_NAME" = "\"uos\"" ] && [ "$OS_VERSION_CODENAME" = "eagle" ]; then
        echo "Update apt sources.list to use internal mirror."
	echo >/etc/apt/sources.list "deb [trusted=yes] http://pools.uniontech.com/desktop-professional eagle main contrib non-free"
fi
