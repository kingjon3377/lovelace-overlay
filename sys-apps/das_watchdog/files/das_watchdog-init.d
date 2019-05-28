#!/sbin/openrc-run
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


NAME="das_watchdog"
EXEC="/usr/sbin/${NAME}"

start() {
	ebegin "Starting $NAME"
	start-stop-daemon --start --quiet --background --exec $EXEC
}

stop() {
	ebegin "Stopping $NAME"
	start-stop-daemon --stop --quiet --oknodo --exec $EXEC
}
