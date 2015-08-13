# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A Macintosh-like Window menu in Java"
HOMEPAGE="http://javagraphics.blogspot.com/2008/11/windows-adding-window-menu.html"
SRC_URI="http://javagraphics.java.net/jars/${PN}.jar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.6
  ${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
  app-arch/unzip
  ${COMMON_DEP}"

S=${WORKDIR}

src_install() {
  java-pkg_dojar "${PN}.jar"
  use doc && java-pkg_dojavadoc build/javadoc
  use source && java-pkg_dosrc src
}
