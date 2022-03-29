# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="org.jacoco.agent"

DESCRIPTION="Java Code Coverage library: agent module"
HOMEPAGE="http://jacoco.org"
SRC_URI="https://github.com/jacoco/jacoco/archive/v0.7.8.tar.gz -> jacoco-0.7.8.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="dev-java/asm:4
	>=dev-java/jacoco-core-${PV}:0"

RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"
BDEPEND=">=virtual/jdk-1.6"
DEPEND="${CDEPEND}"

JAVA_GENTOO_CLASSPATH="
	asm-4
	jacoco-core
"

S="${WORKDIR}/jacoco-${PV}"

src_prepare() {
	default
	# TODO: a) build other modules from this tarball instead of source JARS,
	# b) build and run tests for each
	rm -r jacoco jacoco-maven-plugin jacoco-maven-plugin.test org.jacoco.ant \
		org.jacoco.ant.test org.jacoco.build org.jacoco.core org.jacoco.core.test \
		org.jacoco.doc org.jacoco.examples org.jacoco.examples.test LICENSE.md \
		org.jacoco.report org.jacoco.report.test org.jacoco.tests pom.xml README.md \
		org.jacoco.agent.test org.jacoco.agent.rt.test .travis .travis.yml \
		.travis.sh .appveyor.yml .github || die
}

src_compile() {
	cd org.jacoco.agent.rt || die
	mkdir -p target/classes/META-INF || die
	cat > target/classes/META-INF/MANIFEST.MF <<-EOF
Manifest-Version: 1.0
Implementation-Title: JaCoCo Java Agent
Premain-Class: org.jacoco.agent.rt.internal.PreMain
Implementation-Version: ${PV}
	EOF
	JAVA_JAR_FILENAME=jacocoagent.jar java-pkg-simple_src_compile
	cd ../org.jacoco.agent || die
	mkdir -p target/classes || die
	mv ../org.jacoco.agent.rt/jacocoagent.jar target/classes || die
	java-pkg-simple_src_compile
	mv ${PN}.jar "${S}" || die
}

src_install() {
	# Adapted from java-pkg-simple_src_install
	java-pkg_dojar ${PN}.jar
	if use doc; then
		java-pkg_dojavadoc org.jacoco.agent/target/api
		java-pkg_dojavadoc org.jacoco.agent.rt/target/api
	fi
	if use source; then
		java-pkg_dosrc org.jacoco.agent/src org.jacoco.agent.rt/src
	fi

}
