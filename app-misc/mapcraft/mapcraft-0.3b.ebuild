# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EANT_GENTOO_CLASSPATH="xerces-2 xalan junit"

inherit java-pkg-2 java-ant-2

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
DESCRIPTION="Java based map editor for roleplaying games"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="https://mapcraft.glendale.org.uk/"
COMMON_DEPEND="dev-java/xerces:2
	dev-java/xalan
	dev-java/junit:0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
BDEPEND=">=virtual/jdk-1.4"
DEPEND="${COMMON_DEPEND}"
IUSE="doc source"

S="${WORKDIR}/${PN}-0.3"

PATCHES=(
	"${FILESDIR}/internal-api.patch"
	"${FILESDIR}/incompatible-type.patch"
)

src_prepare() {
	java-ant_rewrite-classpath
	default
}

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
