# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Libpurple (Pidgin) plugin for instagram DMs"
HOMEPAGE="https://github.com/EionRobb/purple-instagram"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="${DEPEND}"
