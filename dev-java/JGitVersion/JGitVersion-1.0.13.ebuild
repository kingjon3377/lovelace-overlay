# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="source" # doc # no doc target

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ant task to make human-readable version number for Git"
HOMEPAGE="https://github.com/Hunternif/JGitVersion"
SRC_URI="https://github.com/Hunternif/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

COMMON_DEP="dev-java/ant-core:0"
#	|| ( dev-java/jgit dev-java/jgit-bin )
#	"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

EANT_BUILD_TARGET="build-release"
EANT_DOC_TARGET=""

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="ant-core"

src_prepare() {
	sed -i -e 's@<jgitversion dir="." property="build.version"/>@<property name="build.version">'"${PV}"'</property>@' build.xml || die
	rm lib/ant/ant.jar || die
	java-pkg_jar-from --into lib/ant ant-core ant.jar || die
#	rm lib/jgit/*.jar || die
#	if has_version dev-java/jgit; then
#		java-pkg_jar-from --into lib/jgit jgit || die
#	else
#		java-pkg_jar-from --into lib/jgit jgit-bin || die
#	fi
#	sed -i -e 's@lib/jgit/org.eclipse.jgit_2.2.0.201212191850-r.jar@lib/jgit/jgit.jar@' build.xml || die
	# FIXME: Package gitective
}

src_install() {
	java-pkg_newjar "build/jgitversion-${PV}.jar" "${PN}.jar"
	java-pkg_newjar "lib/gitective/gitective-core-0.9.9.jar" "gitective-core.jar"
	java-pkg_newjar 'lib/jgit/org.eclipse.jgit_2.2.0.201212191850-r.jar' 'jgit.jar'
	java-pkg_register-ant-task
	use source && java-pkg_dosrc src
}
