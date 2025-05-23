# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2

DESCRIPTION="A Java docking framework for use in cross-platform Swing applications"
HOMEPAGE="https://gitlab.com/scilab/forge/flexdock"
SRC_URI="http://forge.scilab.org/index.php/p/flexdock/downloads/get/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.7"
DEPEND=">=virtual/jdk-1.7
	app-arch/unzip
	dev-java/skinlf
	dev-java/jgoodies-looks"

EANT_DOC_TARGET="doc"

PATCHES=( "${FILESDIR}"/${PN}-1.1.1-nodemo.patch )

src_prepare() {
	default

	#some cleanups
	find . -name '*.so' -exec rm -v {} \;|| die
	find . -name '*.dll' -exec rm -v {} \;|| die

	#remove built-in jars and use the system ones
	cd lib || die
	rm -rvf *.jar jmf|| die
	java-pkg_jar-from skinlf
	java-pkg_jar-from jgoodies-looks-2.0 looks.jar
}

src_install() {
	java-pkg_newjar "build/${P}.jar" "${PN}.jar"
	use doc && java-pkg_dojavadoc build/docs/api
	use source && java-pkg_dosrc src
}
