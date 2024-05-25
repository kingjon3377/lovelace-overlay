# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MY_PV="0.9.6"
DESCRIPTION="Facebook protocol plugin for libpurple"
HOMEPAGE="https://github.com/dequis/purple-facebook"
SRC_URI="https://github.com/dequis/${PN}/releases/download/v${MY_PV}/${PN}-${MY_PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-libs/json-glib
	net-im/pidgin:="
DEPEND="${RDEPEND}"
DOCS=( AUTHORS ChangeLog NEWS README VERSION )

# TODO: Apply https://github.com/dequis/purple-facebook/pull/523 ?
# Or https://github.com/dequis/purple-facebook/compare/master...jschwartzenberg:purple-facebook:master
# Or (part of) https://github.com/dequis/purple-facebook/compare/master...N8Fear:purple-facebook:master.patch
# Or https://github.com/dequis/purple-facebook/compare/master...CMaiku:purple-facebook:master
# Or https://github.com/dequis/purple-facebook/compare/master...petermolnar:purple-facebook:master

PATCHES=(
	"${FILESDIR}/497-applied.patch"
	"${FILESDIR}/18-fix-thrift-stop-failure.patch"
	"${FILESDIR}/20-bump-FB_ORCA_AGENT-version.patch"
)

# TODO: This package may build against bundled copy of libpurple; if so fix to build against system copy.

src_prepare() {
	default
	eautoreconf
}
