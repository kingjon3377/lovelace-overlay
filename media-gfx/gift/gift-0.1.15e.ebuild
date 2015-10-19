# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

DESCRIPTION="The GNU Image-Finding Tool"
HOMEPAGE="http://www.gnu.org/software/gift/"
SRC_URI="mirror://gnu-alpha/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

#IUSE="doc"
IUSE=""
KEYWORDS="amd64 ~x86"

DEPEND="media-gfx/imagemagick
	dev-perl/XML-DOM
	dev-perl/XML-XQL
	dev-perl/Text-Iconv"

RDEPEND="${DEPEND}"

SLOT="0"

GIFT_USER="gift"
GIFT_HOME="/home/${GIFT_USER}/"
GIFT_INIT="gnu-gift"

src_prepare() {
#	use doc || epatch "${FILESDIR}/${PN}-0.1.14-noDoc.patch"
	epatch "${FILESDIR}/${PN}-0.1.14-noDoc.patch"
	rmdir Doc
	epatch "${FILESDIR}/${PN}-0.1.14-ps_params.patch"
#	epatch "${FILESDIR}/${PN}-0.1.14-patch-tid.patch"
#	epatch "${FILESDIR}/${PN}-0.1.14-extra_qualif.patch"

	eautoreconf
}

src_configure() {
#	econf --enable-multithreading \
#		--enable-bayesian \
#		--datadir=/usr/share/${PN} \
#		--includedir=/usr/include/${PN} || die "econf failed"

	econf --enable-multi-threading \
		--enable-bayesian
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README NEWS AUTHORS

	newconfd "${FILESDIR}/${PN}.confd" "${GIFT_INIT}"
	newinitd "${FILESDIR}/${PN}.initd" "${GIFT_INIT}"

	enewuser ${GIFT_USER} -1 /bin/bash ${GIFT_HOME} users
}
