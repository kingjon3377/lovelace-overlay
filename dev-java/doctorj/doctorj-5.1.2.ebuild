# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2

DESCRIPTION="A tool to analyze Java code"
#HOMEPAGE="http://www.incava.org/projects/java/doctorj/"
#SRC_URI="http://www.incava.org/files/${P}.tar.gz"
HOMEPAGE="https://sourceforge.net/projects/doctorj"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=virtual/jre-1.7"
BDEPEND=">=virtual/jdk-1.7
	app-arch/unzip"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

src_compile() {
	eant
}

src_install() {
	eant -Ddestdir="${D}" install
	fperms +x /usr/bin/${PN}
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
}
