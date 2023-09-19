# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-junit"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A tool to analyze Java code"
#HOMEPAGE="http://www.incava.org/projects/java/doctorj/"
#SRC_URI="http://www.incava.org/files/${P}.tar.gz"
HOMEPAGE="https://github.com/jpace/doctorj https://sourceforge.net/projects/doctorj"
SRC_URI="https://github.com/jpace/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"
BDEPEND=">=virtual/jdk-1.7"
DEPEND="test? ( dev-java/junit:0 )
	${COMMON_DEP}"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

RESTRICT="!test? ( test )"

src_compile() {
	eant
}

src_test() {
	eant tests
}

src_install() {
	eant -Ddestdir="${D}" install
	fperms +x /usr/bin/${PN}
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
}
