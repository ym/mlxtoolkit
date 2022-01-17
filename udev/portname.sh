#!/bin/sh
if [ "$1" = 'install' ]; then
	cat >/etc/udev/rules.d/70-net-mlxtoolkit.rules <<EOF
SUBSYSTEM=="net", ACTION=="add", NAME=="", ATTR{phys_port_name}!="", PROGRAM=="$(realpath "$0")", NAME="\$result"
EOF
	exit $?
fi
exec 2>/dev/null # ignore missing phys_port_name
sed 's/^p\([0-9]\+\)/port\1/;s/s\([0-9]\+\)$/-\1/' </sys/"$DEVPATH"/phys_port_name
