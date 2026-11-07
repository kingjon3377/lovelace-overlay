# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qt6-build qmake-utils

DESCRIPTION="Qt library to start applications only once per user"
HOMEPAGE="https://code.qt.io/cgit/qt-solutions/qt-solutions.git/"
COMMIT=777e95ba69952f11eaec0adfb0cb987fabcdecb3
SRC_URI="https://github.com/qtproject/qt-solutions/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
MY_P=qt-solutions-${COMMIT}
S="${WORKDIR}/${MY_P}/${PN}"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="6"
KEYWORDS="~amd64"
IUSE="doc X"

DEPEND="
	dev-qt/qtbase:6
	dev-qt/qtlockedfile:6
	"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${PN}-build-qtsinglecoreapplication.patch"
	"${FILESDIR}/${PN}-remove-included-qtlockedfile.patch"
	"${FILESDIR}/${PN}-qupzilla.patch"
)

src_prepare() {
	# eclass-internal function would be called by qt6-build_src_prepare, but it unconditionally
	# calls cmake_src_prepare, which aborts
	_qt6-build_prepare_env
	# Make sure this external library is unbundled
	rm -rf ../qtlockedfile src/QtLocked* src/qtlocked* || die
	sed -e "s|@QT_INCLUDEDIR@|${QT6_HEADERDIR}|" "${FILESDIR}/${PN}.prf.in" > "${PN}.prf" || die
	sed -e "s|@QT_INCLUDEDIR@|${QT6_HEADERDIR}|" "${FILESDIR}/qtsinglecoreapplication.prf.in" > "qtsinglecoreapplication.prf" || die
	sed -i -E -e 's,.include,\0 <QRegularExpression>\n\0,' -e 's,QRegExp,QRegularExpression,g' src/qtlocalpeer.cpp || die
	default
}

src_configure() {
	./configure -library || die
	eqmake6
}

src_compile() {
	emake
}

DOCS=( README.TXT )

src_install() {
	use doc && local HTML_DOCS=( doc/html/. )
	einstalldocs

	# libraries
	dolib.so lib/*

	# headers
	dodir "${QT6_HEADERDIR}/QtSolutions"
	insinto "${QT6_HEADERDIR}/QtSolutions"
	doins src/qtsinglecoreapplication.h src/QtSingleCoreApplication
	use X && doins src/{QtSingleApplication,${PN}.h}

	# .prf files
	dodir "${QT6_MKSPECSDIR}/features"
	insinto "${QT6_MKSPECSDIR}/features"
	doins qtsinglecoreapplication.prf
	use X && doins ${PN}.prf
}
