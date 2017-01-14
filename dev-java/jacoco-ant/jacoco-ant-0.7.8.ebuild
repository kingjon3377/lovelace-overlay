# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="org.jacoco.ant"

DESCRIPTION="Java Code Coverage library: ant task"
HOMEPAGE="http://jacoco.org"
SRC_URI="https://search.maven.org/remotecontent?filepath=org/jacoco/${MY_PN}/${PV}/${MY_PN}-${PV}-sources.jar"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="dev-java/ant-core:0
	dev-java/asm:4
	>=dev-java/jacoco-core-${PV}:0
	>=dev-java/jacoco-agent-${PV}:0
	>=dev-java/jacoco-report-${PV}:0"

RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${CDEPEND}"

JAVA_GENTOO_CLASSPATH="
	ant-core
	jacoco-report
	jacoco-agent
	asm-4
	jacoco-core
"

src_compile() {
	mkdir -p target/classes/org/jacoco/ant || die
	cp org/jacoco/ant/antlib.xml target/classes/org/jacoco/ant/ || die
	java-pkg-simple_src_compile
}
