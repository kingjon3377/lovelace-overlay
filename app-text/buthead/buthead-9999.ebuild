# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGIT_REPO_URI="git://git.debian.org/git/collab-maint/buthead.git"

inherit git-2 toolchain-funcs

DESCRIPTION="copy all but the first few lines"
HOMEPAGE="http://packages.debian.org/unstable/buthead"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	doman ${PN}.1
	emake DESTDIR="${D}" prefix="/usr" install
}
