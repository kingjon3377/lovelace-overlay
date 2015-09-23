# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

EGIT_REPO_URI="https://github.com/sakisds/pPub.git"

inherit python-single-r1 git-r3

DESCRIPTION="Simple EPUB reader"
HOMEPAGE="https://github.com/sakisds/pPub"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-arch/unzip
	dev-libs/gobject-introspection[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	net-libs/webkit-gtk:3"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fix-unicode-error.patch"
}

src_install() {
	emake PREFIX="${D}/usr" install
}
