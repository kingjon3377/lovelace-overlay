# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Research Project Helper"
HOMEPAGE="https://rphelper.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/v${PV}-source/${PN}-source.zip -> ${P}.zip"

S="${WORKDIR}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=virtual/jdk-1.7
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.7:*"

PATCHES=(
	"${FILESDIR}/keyword_var_name.patch"
)

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
