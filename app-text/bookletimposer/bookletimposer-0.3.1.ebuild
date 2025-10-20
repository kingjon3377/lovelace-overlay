# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DEB_REV=
DEB_PATCH="-5"

DESCRIPTION="PDF imposition toolkit"
HOMEPAGE="https://kjo.herbesfolles.org/bookletimposer/ https://packages.debian.org/sid/bookletimposer"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}${DEB_REV}.orig.tar.xz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}${DEB_REV}${DEB_PATCH}.debian.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/gobject-introspection
	dev-python/pypdf[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]"
BDEPEND=""

DOCS=( CHANGELOG  HACKING  README.md  TODO )

src_prepare() {
	for patch in $(cat "${WORKDIR}/debian/patches/series");do
		eapply "${WORKDIR}/debian/patches/${patch}"
	done
	sed -i -e "s@'share/doc/bookletimposer'@'share/doc/${PF}'@" setup.py || die
	default
}

# TODO: Also run Debian integration test
distutils_enable_tests pytest
