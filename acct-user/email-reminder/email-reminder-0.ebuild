# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="Daemon user for app-misc/email-reminder"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( email-reminder )

ACCT_USER_HOME="/var/spool/email-reminder"
ACCT_USER_HOME_OWNER="email-reminder:email-reminder"
ACCT_USER_HOME_PERMS=750

acct-user_add_deps
