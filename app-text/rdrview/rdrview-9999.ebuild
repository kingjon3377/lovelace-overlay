# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Strip cruft from HTML (Readability)"
HOMEPAGE="https://github.com/eafer/rdrview"
SRC_URI=""
EGIT_REPO_URI="https://github.com/eafer/${PN}.git"

IUSE="test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-libs/libseccomp
	dev-libs/libxml2:2
	net-misc/curl"
DEPEND="${RDEPEND}
	test? (
		app-text/htmltidy
		dev-util/valgrind
		www-client/links
	)"
BDEPEND=""

# Tests fail to run if mailcap not set up, TODO: report
RESTRICT=test

src_prepare() {
	sed -i -e 's@^CFLAGS = \(.* \)-O2 -Wall -Wextra\( .*\)@CFLAGS += \1 \2@' \
		-e "s@/usr/local\$@${EPREFIX}/usr@" Makefile || die
	default
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" PREFIX="${EPREFIX}/usr"
}

src_test() {
	cd tests && ./check || die "tests failed"
}
