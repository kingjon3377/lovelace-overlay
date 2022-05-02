# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# Copyright 2021 Gordon Bos

EAPI=8

inherit acct-user

DESCRIPTION="A user for iTunes Digital Audio Access Protocol server"
ACCT_USER_ID=112
ACCT_USER_GROUPS=( daapd )

acct-user_add_deps
