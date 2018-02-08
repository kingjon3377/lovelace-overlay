# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc"

WANT_ANT_TASKS="ant-contrib ant-antlr ant-bndlib ant-junit"

if test "${PV}" = 9999; then
	inherit java-pkg-2 java-ant-2 git-r3 bash-completion-r1
	EGIT_REPO_URI="https://github.com/eclipse/${PN}.git"
	SRC_URI=""
else
	inherit java-pkg-2 java-ant-2 bash-completion-r1
	#SRC_URI="https://github.com/eclipse/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/eclipse/${PN}/archive/_old%2F${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Elegant, readable, highly typesafe JVM programming language"
HOMEPAGE="https://ceylon-lang.org"

LICENSE="Apache-2.0 GPL-2-with-classpath-exception LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

RESTRICT=test # fails, looks like missing deps, FIXME: investigate

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
	dev-java/stringtemplate:4
	dev-java/sun-jai-bin:0
	dev-java/batik:1.9"

RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.7
	test? ( dev-java/ant-junit:0 )
	${COMMON_DEP}"

#JAVA_ANT_REWRITE_CLASSPATH=true
EANT_BUILD_TARGET="dist"
EANT_DOC_TARGET="generate-apidoc"
EANT_GENTOO_CLASSPATH="antlr-3.5,hamcrest-core-1.3,osgi-core-api,ant-bndlib,stringtemplate-4,ant-antlr"

# Build file rewriting somehow breaks the build, even with classpath-injection off
# But with that off, missing-from-classpath failures return ...
#JAVA_PKG_BSFIX=off

src_prepare() {
	for jar in ant-1.8.2.jar ant-contrib-1.0b3.jar antlr-complete-3.5.2.jar \
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
	sed -i -e 's@\(<classpathentry kind="lib" path="/ceylon/lib/\)antlr-complete-3.5.2.jar\("/>\)@\1/antlr-runtime.jar\2\1antlr-tool.jar\2\1ant-antlr.jar\2@' \
		compiler-js/.classpath typechecker/.classpath || die
	sed -i -e 's@\(<pathelement location="\)${antlr\.lib}\(" ></pathelement>\|"[ 	]*/>\)@\1${base.path}/antlr-runtime.jar\2\1${base.path}/antlr-tool.jar\2\1${base.path}/ant-antlr.jar\2\1${base.path}/stringtemplate.jar\2@' \
		-e 's@\(<pathelement path="\)${antlr\.lib}\(" ></pathelement>\|"[ 	]*/>\)@\1${base.path}/antlr-runtime.jar\2\1${base.path}/antlr-tool.jar\2\1${base.path}/ant-antlr.jar\2\1${base.path}/stringtemplate.jar\2\1${base.path}/ant.jar\2@' \
		-e 's@\(classpath="\)${antlr.lib}\(\"\)@\1${base.path}/antlr-runtime.jar:${base.path}/antlr-tool.jar:${base.path}/ant-antlr.jar:${base.path}/stringtemplate.jar\2@' typechecker/build.xml compiler-java/build.xml compiler-js/build.xml || die
	#sed -i -e 's@/antlr-3.4-complete.jar"@/antlr-runtime.jar"@' compiler-js/.classpath \
		#typechecker/.classpath || die
	java-pkg_jar-from --into lib hamcrest-core-1.3
	sed -i -e 's@/hamcrest-core-1.3.0.v201303031735.jar"@/hamcrest-core.jar"@' \
		compiler-java/.classpath || die
	sed -i -e 's@hamcrest-core-${hamcrest\.version}.jar@hamcrest-core.jar@' lib/build.properties || die
	java-pkg_jar-from --into lib junit-4
	sed -i -e 's@/junit-4.11.0.jar"@/junit.jar"@' compiler-java/.classpath || die
	sed -i -e 's@^\(junit\.jar=\)junit-${junit\.version}.jar$@\1junit.jar@' lib/build.properties || die
	java-pkg_jar-from --into lib osgi-core-api
	sed -i -e 's@/org.osgi.core-4.3.1.jar"@/osgi-core-api.jar"@' dist/osgi/build.xml || die
	java-pkg_jar-from --into lib bndlib
	java-pkg_jar-from --into lib ant-bndlib
	sed -i -e 's@/biz.aQute.bnd-2.3.0.jar"@/ant-bndlib.jar"@' dist/build.xml || die
	java-pkg_jar-from --into lib stringtemplate-4
	sed -i -e "s@\${user.home}@${T}@" language/build.xml dist/build.xml dist/osgi/build.xml \
		compiler-java/langtools/make/build.xml || die
	sed -i -e '/--stacktraces/{
			N
			s@\(<arg value="--stacktraces"[ 	]*\)\(></arg>\|/>\)\([\n 	]*<arg value="doc-tool"[ 	]*\)\2@\1\2<arg value="--define=ceylon.cache.repo=${ceylon.cache.repo}" />\3\2@
		}' \
		dist/build.xml || die
	rm tool-provider/lib/junit-4.9b2.jar || die
	java-pkg_jar-from --into tool-provider/lib junit-4
	sed -i -e 's@lib/junit-4.9b2.jar@lib/junit.jar@' \
		tool-provider/test-launcher/com/redhat/ceylon/compiler/java/runtime/launcher/ToolsTestRunner.java || die
	rm typechecker/support/lib/jai_codec.jar typechecker/support/lib/jai_core.jar || die
	java-pkg_jar-from --into typechecker/support/lib/ sun-jai-bin jai_codec.jar
	java-pkg_jar-from --into typechecker/support/lib/ sun-jai-bin jai_core.jar
	rm typechecker/support/lib/batik.jar || die
	java-pkg_jar-from --into typechecker/support/lib batik-1.9 batik.jar
	rm runtime/dist/repo/org/antlr/runtime/3.5.2/org.antlr.runtime-3.5.2.jar || die
	java-pkg_jar-from --into runtime/dist/repo/org/antlr/runtime/3.5.2 antlr-3.5 antlr-runtime.jar org.antlr.runtime-3.5.2.jar
	# It appears we don't actually need this, so let's just strip it
	rm gradle/wrapper/gradle-wrapper.jar || die
	# TODO: unbundle other libraries:
	# - In $S/lib:
	#   - lib/org.osgi.impl.bundle.bindex-2.2.0.jar [not in Portage AFAICS]
	#   - lib/shrinkwrap-impl-base-1.0.0-cr-1.jar [not in Portage AFAICS]
	#   - lib/xmltask-1.16.jar [not in Portage AFAICS]
	#   - lib/org.osgi.impl.bundle.repoindex.ant-2.1.2.jar [not in Portage AFAICS]
	#   - lib/shrinkwrap-api-1.0.0-cr-1.jar [not in Portage AFAICS]
	#   - lib/shrinkwrap-spi-1.0.0-cr-1.jar [not in Portage AFAICS]
	# - In $S/debug:
	#   - httpcore-4.1.1-sources.jar [not in Portage]
	#   - shrinkwrap-resolver-impl-maven-2.2.0-beta-1-sources.jar [not in Portage]
	#   - shrinkwrap-resolver-api-2.2.0-beta-1-sources.jar [not in Portage]
	#   - sardine-5.1-sources.jar [not in Portage]
	#   - shrinkwrap-resolver-api-maven-2.2.0-beta-1-sources.jar [not in Portage]
	#   - httpclient-4.1.1-sources.jar [not in Portage]
	#   - jboss-modules-1.4.4.Final-sources.jar [Portage is at version 1.3.3]
	#   - jandex-1.0.3.Final-sources.jar [not in Portage]
	# - In $S/cmr/maven/src/test/resources/maven/settings/repository:
	#   - org/sl4j/slf4j-api/1.6.1/slf4j-api-1.6.1.jar [in Portage in version 1.7.7; need to mangle path and references ...]
	#   - org/osgi/org.osgi.core/4.0.0/org.osgi.core-4.0.0.jar [in Portage in version 5.0.0, which may or may not work; need to mangle path and references]
	#   - org/apache/camel/camel-core/2.9.2/camel-core-2.9.2.jar [not in Portage]
	# - In $S/typechecker/support/lib:
	#   - fop-0.20.5-RFC3066-patched.jar [Is this the same as dev-java/fop, in Portage in version 2.0-r3?]
	#   - rowan-0.1.jar [not in Portage, AFAICS]
	#   - saxon-dbxsl-extensions.jar [not in Portage, AFAICS]
	#   - saxon.jar [looks like this isn't the F/OSS version, since it contains com.icl.saxon instead of net.sf.saxon]
	#   - avalon-framework-cvs-20020806.jar [will either the 4.1 or the 4.2 SLOT work for this?]
	# - In $S/runtime/dist/repo:
	#   - com/github/rjeschke/txtmark/0.13/com.github.rjeschke.txtmark-0.13.jar [not in Portage AFAICS]
	#   - com/redhat/ceylon/aether/3.3.9/com.redhat.ceylon.aether-3.3.9.jar [not in Portage, of course]
	#   - net/minidev/json-smart/1.3.1/net.minidev.json-smart-1.3.1.jar [not in Portage, AFAICS]
	#   - org/tautua/markdownpapers/core/1.3.4/org.tautua.markdownpapers.core-1.3.4.jar [not in Portage, AFAICS]
	#   - org/jboss/logmanager/2.0.3.Final/org.jboss.logmanager-2.0.3.Final.jar [in Portage as jboss-logmanager, but only at version 1.5.1]
	#   - org/jboss/modules/1.4.4.Final/org.jboss.modules-1.4.4.Final.jar [in Portage as jboss-modules, but only at version 1.3.3]
	eapply_user
}

src_compile() {
	cd "${S}/dist"
	eant install-all generate-tooldoc
	use doc && eant -Duser.home="${T}" generate-spec generate-apidoc
}

src_test() {
	eant test
}

src_install() {
	cd "${S}/dist"
	dodir /usr/share/${PN}
	dodir /usr/share/doc/${PF}/en
	dosym ../doc/${PF} /usr/share/${PN}/doc
	insinto /usr/share/doc/${PF}/en
	doins -r dist/doc/en/*
	for dir in bin repo lib samples templates contrib; do
		dodir "/usr/share/${PN}/${dir}"
		insinto "/usr/share/${PN}/${dir}"
		doins -r "dist/${dir}"/*
	done
	doman dist/doc/man/man*/*.?
	dodir /usr/bin
	dosym ../share/${PN}/bin/${PN} /usr/bin/${PN}
	fperms +x /usr/share/${PN}/bin/${PN}
	dodoc dist/README.md
	docinto examples
	dodoc dist/contrib/scripts/ceylon-example
	newbashcomp dist/contrib/scripts/${PN}-completion.bash ${PN}
}
