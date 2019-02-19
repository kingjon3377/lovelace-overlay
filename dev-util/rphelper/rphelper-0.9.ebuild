# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Research Project Helper"
HOMEPAGE="http://rphelper.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/v${PV}-source/${PN}-source.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.3
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.3:*"

S="${WORKDIR}"

src_prepare() {
	default
	sed -i -e 's@src\.@rphelper.@' ${PN}/abxmldoc/*.java || die
	mkdir -p target/META-INF
	cat > target/META-INF/MANIFEST.MF <<-EOF
Manifest-Version: 1.0
Main-Class: rphelper.RPHelper
EOF
	mkdir -p target/${PN}/ui
	cp ${PN}/ui/help.html target/${PN}/ui/ || die
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher
	dodoc ${PN}/ui/help.html
}
