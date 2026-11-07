# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qt6-build qmake-utils

DESCRIPTION="QFile extension with advisory locking functions"
HOMEPAGE="https://code.qt.io/cgit/qt-solutions/qt-solutions.git/"
COMMIT=777e95ba69952f11eaec0adfb0cb987fabcdecb3
SRC_URI="https://github.com/qtproject/qt-solutions/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
MY_P=qt-solutions-${COMMIT}
S="${WORKDIR}/${MY_P}/${PN}"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="6"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-qt/qtbase:6"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	# eclass-internal function would be called by qt6-build_src_prepare, but it unconditionally
	# calls cmake_src_prepare, which aborts
	_qt6-build_prepare_env
	sed -e "s|@QT_INCLUDEDIR@|${QT6_HEADERDIR}|" "${FILESDIR}/${PN}.prf.in" > "${PN}.prf" || die
	sed -i -e "s@-head@-$(ver_cut 1-2)@" common.pri || die
	default
}

src_configure() {
	./configure -library || die
	eqmake6
}

src_compile() {
	emake
}

src_install() {
	use doc && local HTML_DOCS=( doc/html/. )
	einstalldocs

	# libraries
	dolib.so lib/*

	# headers
	dodir "${QT6_HEADERDIR}/QtSolutions"
	insinto "${QT6_HEADERDIR}/QtSolutions"
	doins src/QtLockedFile src/${PN}.h

	# .prf files
	dodir "${QT6_MKSPECSDIR}/features"
	insinto "${QT6_MKSPECSDIR}/features"
	doins ${PN}.prf
}
