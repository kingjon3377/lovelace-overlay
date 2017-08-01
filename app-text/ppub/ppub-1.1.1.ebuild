# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

#EGIT_REPO_URI="https://github.com/sakisds/pPub.git"
#EGIT_REPO_URI="https://github.com/kstopa/pPub.git"

inherit python-single-r1 # git-r3

DESCRIPTION="Simple EPUB reader"
HOMEPAGE="https://github.com/kstopa/pPub"
SRC_URI="https://github.com/kstopa/pPub/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/pPub-${PV}"

RDEPEND="dev-libs/gobject-introspection[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	net-libs/webkit-gtk:3"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fix-unicode-error.patch" "${FILESDIR}/${P}-create-icon-directories.patch"
}

src_install() {
	emake PREFIX="${D}/usr" install
}
