# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="org.jacoco.core"

DESCRIPTION="Java Code Coverage library: core"
HOMEPAGE="http://jacoco.org"
SRC_URI="https://search.maven.org/remotecontent?filepath=org/jacoco/${MY_PN}/${PV}/${MY_PN}-${PV}-sources.jar"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="dev-java/asm:4"

RDEPEND=">=virtual/jre-1.6
	!dev-java/jacoco
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${CDEPEND}"

JAVA_GENTOO_CLASSPATH="asm-4"

src_compile() {
	mkdir -p target/classes/org/jacoco/core || die
	cp org/jacoco/core/jacoco.properties target/classes/org/jacoco/core/ || die
	java-pkg-simple_src_compile
}
