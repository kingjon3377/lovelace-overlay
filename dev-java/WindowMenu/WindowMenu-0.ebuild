# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A Macintosh-like Window menu in Java"
HOMEPAGE="http://javagraphics.blogspot.com/2008/11/windows-adding-window-menu.html"
SRC_URI="http://javagraphics.java.net/jars/${PN}.jar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.7"
DEPEND=">=virtual/jdk-1.7
	app-arch/unzip"

S=${WORKDIR}
