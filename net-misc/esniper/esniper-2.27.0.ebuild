# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

MY_P=${PN}-$(replace_all_version_separators '-')
DESCRIPTION="A simple, lightweight tool for sniping ebay auctions"
HOMEPAGE="http://esniper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl
	>=net-misc/curl-7.12[ssl]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dobin frontends/snipe || die
	dodoc AUTHORS ChangeLog NEWS README TODO sample_auction.txt sample_config.txt || die
}

pkg_postinst() {
	elog
	elog "Please find a sample config at /usr/share/doc/${P}/sample_config.txt.bz2"
	elog
}
