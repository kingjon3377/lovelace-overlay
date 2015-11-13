# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games java-pkg-2 java-pkg-simple git-r3

DESCRIPTION="Infinite Mario levels adapting to player skill"
HOMEPAGE="https://github.com/bnoordhuis/Infinite-Adaptive-Mario"
SRC_URI=""
EGIT_REPO_URI="https://github.com/bnoordhuis/Infinite-Adaptive-Mario.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5:*"

JAVA_SRC_DIR="${P}/src/main/java"

src_prepare() {
	mkdir -p target/classes
	cp -r "${P}/src/main/resources/"* target/classes || die
	mkdir -p target/classes/META-INF
	cat > target/classes/META-INF/MANIFEST.MF <<-EOF
Manifest-Version: 1.0
Main-Class: dk.itu.mario.engine.PlayCustomized
EOF
}

src_install() {
	java-pkg_dolauncher "${PN}" --jar "${PN}.jar" --into "${GAMES_BINDIR}"
}
