# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-contrib ant-antlr ant-bndlib"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Elegant, readable, highly typesafe JVM programming language"
HOMEPAGE="https://ceylon-lang.org"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2-with-classpath-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="dev-java/ant-core:0
	dev-java/ant-contrib:0
	dev-java/antlr:3.5
	dev-java/hamcrest-core:1.3
	dev-java/junit:4
	dev-java/osgi-core-api:0
	dev-java/bndlib:0
	dev-java/ant-bndlib:0
	dev-java/stringtemplate:4"

RDEPEND=">=virtual/jre-1.8
  ${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.8
  ${COMMON_DEP}"

JAVA_ANT_REWRITE_CLASSPATH=true
EANT_BUILD_TARGET="dist"
EANT_DOC_TARGET=""
EANT_GENTOO_CLASSPATH="antlr-3.5,hamcrest-core-1.3,osgi-core-api,ant-bndlib,stringtemplate-4"

src_prepare() {
	for jar in ant-1.8.2.jar ant-contrib-1.0b3.jar antlr-3.4-complete.jar \
			hamcrest-core-1.3.0.v201303031735.jar junit-4.11.0.jar org.osgi.core-4.3.1.jar \
			biz.aQute.bnd-2.3.0.jar
	do
		rm lib/"${jar}" || die
	done
	java-pkg_jar-from --into lib ant-core
	java-pkg_jar-from --into lib ant-contrib
	java-pkg_jar-from --into lib antlr-3.5
	java-pkg_jar-from --into lib hamcrest-core-1.3
	java-pkg_jar-from --into lib junit-4
	java-pkg_jar-from --into lib osgi-core-api
	java-pkg_jar-from --into lib bndlib
	java-pkg_jar-from --into lib ant-bndlib
	java-pkg_jar-from --into lib stringtemplate-4
	eapply_user
}

src_install() {
  java-pkg_dojar "${PN}.jar"
  use doc && java-pkg_dojavadoc build/javadoc
  use source && java-pkg_dosrc src
}
