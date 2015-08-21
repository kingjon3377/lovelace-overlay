# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

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
	# FIXME: Package JGit and gitective
}

src_install() {
	java-pkg_dojar "build/jgitversion-${PV}.jar""${PN}.jar"
	java-pkg_register-ant-task
	use source && java-pkg_dosrc src
}
