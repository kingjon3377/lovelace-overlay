# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxml/pyxml-0.8.4-r3.ebuild,v 1.4 2013/02/02 22:00:18 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 eutils

MY_P=${P/pyxml/PyXML}

DESCRIPTION="A collection of libraries to process XML with Python"
HOMEPAGE="http://pyxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD CNRI MIT PSF-2 public-domain"
# Other licenses:
# BeOpen Python Open Source License Agreement Version 1
# Zope Public License (ZPL) Version 1.0
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"

DEPEND=">=dev-libs/expat-1.95.6"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${P}-python-2.6.patch"
		"${FILESDIR}/fix-syntax-error.patch"
	)

	# Delete internal copy of old version of unittest module.
	rm -f test/unittest.py

	distutils-r1_python_prepare_all
}

python_compile() {
	local myconf

	# if you want to use 4Suite, then their XSLT/XPATH is
	# better according to the docs
	if has_version "dev-python/4suite"; then
		myconf="--without-xslt --without-xpath"
	else
		myconf="--with-xslt --with-xpath"
	fi

	# use the already-installed shared copy of libexpat
	distutils-r1_python_compile --with-libexpat="${EPREFIX}/usr" ${myconf}
}

python_test() {
	cd test || die
	PYTHONPATH="${S}-${EPYTHON/./_}/lib" "${PYTHON}" regrtest.py || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( ANNOUNCE CREDITS doc/*.txt )

	distutils-r1_python_install_all

	doman doc/man/*
	if use doc; then
		dohtml -A api,web -r doc/*
		dodoc doc/*.tex
	fi
	use examples && dodoc -r demo
}
