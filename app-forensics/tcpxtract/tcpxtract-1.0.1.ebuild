# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="extracts files from network traffic based on file signatures"
HOMEPAGE="https://tcpxtract.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_compile() {
	default_src_compile -DDEFAULT_CONFIG_FILE=\"/etc/tcpxtract.conf\"
}

src_install() {
	dobin tcpxtract
	doman tcpxtract.1
	insinto /etc
	doins tcpxtract.conf
	dodoc AUTHORS ChangeLog NEWS
}
