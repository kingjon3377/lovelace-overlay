# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Compressed alternative to BitSet"
HOMEPAGE="https://github.com/lemire/javaewah"
SRC_URI="https://github.com/lemire/javaewah/archive/JavaEWAH-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples"

# TODO: Make a build-time dep only?
COMMON_DEP="dev-java/junit:4"

S="${WORKDIR}/${PN}-JavaEWAH-${PV}"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

JAVA_GENTOO_CLASSPATH="junit-4"

# TODO: run tests

src_install() {
	java-pkg-simple_src_install
	dodoc CHANGELOG README.md
	if use examples; then
		dodoc example.java
		dodoc -r examples
	fi
}
