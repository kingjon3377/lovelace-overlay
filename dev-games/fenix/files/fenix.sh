#!/bin/sh

# (c) 2007 Miriam Ruiz <little_miry@yahoo.es>
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

ARG="$1"
GAME_FILE=""

if [ -z "$GAME_FILE" ] && [ -z "$ARG" ]; then
	FILE_NUM=`ls *.prg 2>/dev/null | wc -l`
	if [ "$FILE_NUM" -eq 1 ] ; then
		GAME_FILE=`ls *.prg 2>/dev/null`
	else
		GAME_FILE=""
	fi
fi

if [ -z "$GAME_FILE" ] && [ -d "$ARG" ]; then
	FILE_NUM=`ls "$ARG"/*.prg 2>/dev/null | wc -l`
	if [ "$FILE_NUM" -eq 1 ] ; then
		GAME_FILE=`ls "$ARG"/*.prg` 2>/dev/null
	else
		GAME_FILE=""
		echo "Cannot choose a game file in the directory \"$ARG\"" >&2
		exit 1
	fi
fi

if [ -z "$GAME_FILE" ] && [ -e "$ARG" ]; then
	FILE_NUM=`ls "$ARG" 2>/dev/null | wc -l`
	if [ "$FILE_NUM" -eq 1 ] ; then
		GAME_FILE="$ARG"
	else
		GAME_FILE=""
		echo "Cannot choose a game file" >&2
	fi
fi

if [ -z "$GAME_FILE" ] && [ ! -z "$ARG" ] && [ -z "$2" ]; then
	echo "Game program does not exist in \"$ARG\"" >&2
	exit 1
fi

if [ -z "$GAME_FILE" ] || [ ! -z "$2" ]; then
	echo "Usage: $0" >&2
	echo "Usage: $0 <file.prg>" >&2
	echo "Usage: $0 <directory>" >&2
	exit 1
fi

if [ -z "$GAME_FILE" ] || [ ! -e "$GAME_FILE" ]; then
	echo "File \"$GAME_FILE\" does not exist" >&2
	exit 1
fi

echo "Game File: \"$GAME_FILE\"" >&2
fenix-fxc "$GAME_FILE" -o - | fenix-fxi -t "$GAME_FILE" -
