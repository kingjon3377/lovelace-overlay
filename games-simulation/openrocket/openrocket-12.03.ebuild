# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

WANT_ANT_TASKS="ant-junit"

inherit java-pkg-2 java-ant-2

MY_P=OpenRocket-${PV}

DESCRIPTION="Model rocket simulator"
HOMEPAGE="http://openrocket.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${MY_P}-src.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc source"

CDEPEND="dev-java/itext:5
	dev-java/jcommon:1.0
	dev-java/jfreechart:1.0
	dev-java/miglayout"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"

S="${WORKDIR}/${MY_P}"

src_compile() {
	java-pkg-2_src_compile
}

src_test() {
	eant unittest
}

src_install() {
	java-pkg_dojar build/jar/"OpenRocket.jar"
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
	doicon resources/pix/icon/icon-064.png
	doman "${FILESDIR}/${PN}.1"
	domenu "${FILESDIR}/${PN}.desktop"
	java-pkg_dolauncher openrocket --jar OpenRocket.jar
	dodoc ChangeLog fileformat.txt README.TXT ReleaseNotes TODO
	dodoc -r resources/datafiles
}
