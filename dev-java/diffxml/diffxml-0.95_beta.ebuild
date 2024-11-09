# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"
EANT_TEST_TARGET="fullTest"

inherit java-pkg-2

DESCRIPTION="XML differencing and packaging tools"
HOMEPAGE="https://diffxml.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PV/_beta/%20BETA}/${PN}-src-${PV/_beta/B}.tar.gz"

S="${WORKDIR}/${PN}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

COMMON_DEP="dev-java/xpp3"

RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.7
	test? ( dev-java/junit:4 )
	${COMMON_DEP}"

EANT_BUILD_TARGET="jarDiffXML"
EANT_DOC_TARGET=""

RESTRICT="!test? ( test )"

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_dojar build/"${PN}.jar"
	dodir /usr/bin
	java-pkg_dolauncher diffxml \
		--main org.diffxml.diffxml.DiffXML \
		--jar "${PN}.jar"
	java-pkg_dolauncher patchxml \
		--main org.diffxml.patchxml.PatchXML \
		--jar "${PN}.jar"
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
	dodoc CHANGELOG.txt README.txt TODO.txt
}
