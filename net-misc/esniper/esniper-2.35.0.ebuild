# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=${PN}-$(ver_rs 1- '-')
DESCRIPTION="A simple, lightweight tool for sniping ebay auctions"
HOMEPAGE="https://esniper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/openssl:0
	>=net-misc/curl-7.12[ssl]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install
	dobin frontends/snipe
	dodoc AUTHORS ChangeLog NEWS README TODO sample_auction.txt sample_config.txt
}

pkg_postinst() {
	echo
	einfo "Please find a sample config at /usr/share/doc/${PF}/sample_config.txt.bz2"
	echo
}
