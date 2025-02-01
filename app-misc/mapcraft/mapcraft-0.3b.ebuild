# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EANT_GENTOO_CLASSPATH="xerces-2 xalan junit"

inherit java-pkg-2

DESCRIPTION="Java based map editor for roleplaying games"
HOMEPAGE="https://mapcraft.glendale.org.uk/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tgz"
S="${WORKDIR}/${PN}-0.3"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
COMMON_DEPEND="dev-java/xerces:2
	dev-java/xalan:0
	dev-java/junit:0"
RDEPEND=">=virtual/jre-1.7
	${COMMON_DEPEND}"
BDEPEND=">=virtual/jdk-1.7"
DEPEND="${COMMON_DEPEND}"
IUSE="doc source"

PATCHES=(
	"${FILESDIR}/internal-api.patch"
	"${FILESDIR}/incompatible-type.patch"
)

src_compile() {
	EANT_GENTOO_CLASSPATH="xerces-2 xalan junit" eant
}

src_install() {
	SAMPLESDIR=/usr/share/mapcraft/samples
	dodir $SAMPLESDIR

	java-pkg_dojar "${PN}.jar"
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
	java-pkg_dolauncher ${PN} --main net.sourceforge.mapcraft.MapCraft \
		--java_args -Xmx1024m
	insinto $SAMPLESDIR
	doins maps/*.map

	dodoc NOTES PLAN README
}
