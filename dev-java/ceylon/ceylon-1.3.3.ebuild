# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-contrib ant-antlr ant-bndlib"

if test "${PV}" = 9999; then
	inherit java-pkg-2 java-ant-2 git-r3
	EGIT_REPO_URI="https://github.com/eclipse/${PN}.git"
	SRC_URI=""
else
	inherit java-pkg-2 java-ant-2
	#SRC_URI="https://github.com/eclipse/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/eclipse/${PN}/archive/_old%2F${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Elegant, readable, highly typesafe JVM programming language"
HOMEPAGE="https://ceylon-lang.org"

LICENSE="Apache-2.0 GPL-2-with-classpath-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

# With 1.3.3 being grandfathered into the Eclipse-branded repository, it needs this oddity
S="${WORKDIR}/${PN}-_old-${PV}"

COMMON_DEP="dev-java/ant-core:0
	dev-java/ant-contrib:0
	dev-java/antlr:3.5
	dev-java/ant-antlr:0
	dev-java/hamcrest-core:1.3
	dev-java/junit:4
	dev-java/osgi-core-api:0
	dev-java/bndlib:0
	dev-java/ant-bndlib:0
	dev-java/stringtemplate:4"

RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.7
	${COMMON_DEP}"

#JAVA_ANT_REWRITE_CLASSPATH=true
EANT_BUILD_TARGET="dist"
EANT_DOC_TARGET=""
EANT_GENTOO_CLASSPATH="antlr-3.5,hamcrest-core-1.3,osgi-core-api,ant-bndlib,stringtemplate-4"

# Build file rewriting somehow breaks the build, even with classpath-injection off
# But with that off, missing-from-classpath failures return ...
#JAVA_PKG_BSFIX=off

src_prepare() {
	for jar in ant-1.8.2.jar ant-contrib-1.0b3.jar antlr-3.4-complete.jar \
			hamcrest-core-1.3.0.v201303031735.jar junit-4.11.0.jar org.osgi.core-4.3.1.jar \
			biz.aQute.bnd-2.3.0.jar
	do
		rm lib/"${jar}" || die
	done
	java-pkg_jar-from --into lib ant-core
	sed -i -e 's@"/ceylon/lib/ant-1.8.2.jar"@"/ceylon/lib/ant.jar"@' compiler-java/.classpath \
		compiler-js/.classpath || die
	java-pkg_jar-from --into lib ant-contrib
	sed -i -e 's@/ant-contrib-1.0b3.jar"@/ant-contrib.jar"@' dist/sdk-build.xml dist/osgi/build.xml \
		dist/build.xml dist/ide-build.xml || die
	java-pkg_jar-from --into lib antlr-3.5
	java-pkg_jar-from --into lib ant-antlr
	sed -i -e 's@\(<classpathentry kind="lib" path="/ceylon/lib/\)antlr-3.4-complete.jar\("/>\)@\1/antlr-runtime.jar\2\1antlr-tool.jar\2\1ant-antlr.jar\2@' compiler-js/.classpath typechecker/.classpath || die
	#sed -i -e 's@/antlr-3.4-complete.jar"@/antlr-runtime.jar"@' compiler-js/.classpath \
		#typechecker/.classpath || die
	java-pkg_jar-from --into lib hamcrest-core-1.3
	sed -i -e 's@/hamcrest-core-1.3.0.v201303031735.jar"@/hamcrest-core.jar"@' \
		compiler-java/.classpath || die
	java-pkg_jar-from --into lib junit-4
	sed -i -e 's@/junit-4.11.0.jar"@/junit.jar"@' compiler-java/.classpath || die
	java-pkg_jar-from --into lib osgi-core-api
	sed -i -e 's@/org.osgi.core-4.3.1.jar"@/osgi-core-api.jar"@' dist/osgi/build.xml || die
	java-pkg_jar-from --into lib bndlib
	java-pkg_jar-from --into lib ant-bndlib
	sed -i -e 's@/biz.aQute.bnd-2.3.0.jar"@/ant-bndlib.jar"@' dist/build.xml || die
	java-pkg_jar-from --into lib stringtemplate-4
	eapply_user
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
}
