# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/qt-unixODBC/qt-unixODBC-3.3.8b.ebuild,v 1.6 2009/01/17 16:39:16 nixnut Exp $

EAPI=5

inherit eutils

SRCTYPE="free"
DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"
SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-${SRCTYPE}-${PV}.tar.gz"
IUSE=""
LICENSE="|| ( QPL-1.0 GPL-2 GPL-3 )"
SLOT="3"
KEYWORDS="amd64 ~x86"

RDEPEND="~dev-qt/qt-meta-${PV}
	dev-db/unixODBC"
DEPEND="${RDEPEND}
	>=dev-db/unixODBC-2.2.14"

S="${WORKDIR}/qt-x11-${SRCTYPE}-${PV}"

QTBASE="/usr/qt/3"
export QTDIR=${S}
export PLATFORM=linux-g++

src_prepare() {
	epatch "${FILESDIR}"/qt-no-rpath.patch
	epatch "${FILESDIR}"/unixODBC-2.2.14.patch

	sed -i -e 's:read acceptance:acceptance=yes:' configure || die "sed to make configure noninteractive failed"

	sed -i -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		   -e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		   -e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		   -e "s:\<QMAKE_CC\>.*=.*:QMAKE_CC=$(tc-getCC):" \
		   -e "s:\<QMAKE_CXX\>.*=.*:QMAKE_CXX=$(tc-getCXX):" \
		   -e "s:\<QMAKE_LINK\>.*=.*:QMAKE_LINK=$(tc-getCXX):" \
		   -e "s:\<QMAKE_LINK_SHLIB\>.*=.*:QMAKE_LINK_SHLIB=$(tc-getCXX):" \
		   "${S}"/mkspecs/${PLATFORM}/qmake.conf || die "sed to fix CFLAGS failed"
}

src_configure() {
	export QTDIR=${S}
	export SYSCONF=${D}${QTBASE}/etc/settings

	# Let's just allow writing to these directories during Qt emerge
	# as it makes Qt much happier.
	addwrite "${QTBASE}/etc/settings"
	addwrite "${HOME}/.qt"

	export YACC='byacc -d'

	./configure -sm -thread -stl -system-libjpeg -verbose -largefile \
		-qt-imgfmt-{jpeg,mng,png} -tablet -system-libmng \
		-system-libpng -lpthread -xft -platform ${PLATFORM} -xplatform \
		${PLATFORM} -xrender -prefix ${QTBASE} -fast ${myconf} \
		-dlopen-opengl -plugin-sql-odbc -L${QTBASE}/lib || die "configure failed"
}

src_compile() {
	emake -C "${s}/plugins/src/sqldrivers/odbc" || die "emake failed"
}

src_install() {
	insinto ${QTBASE}/plugins/sqldrivers
	doins "${S}"/plugins/sqldrivers/libqsqlodbc.so || die "doins failed"
}
