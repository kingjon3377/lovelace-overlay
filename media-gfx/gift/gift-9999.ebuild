# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECVS_SERVER="cvs.sv.gnu.org:/sources/gift"
ECVS_MODULE="gift"

inherit eutils autotools cvs

DESCRIPTION="The GNU Image-Finding Tool"
HOMEPAGE="https://www.gnu.org/software/gift/"
SRC_URI=""
LICENSE="LGPL-2.1"

IUSE="" #"doc"
KEYWORDS="~amd64 ~x86"

DEPEND="media-gfx/imagemagick
	dev-perl/XML-DOM
	dev-perl/XML-XQL
	dev-perl/Text-Iconv"

RDEPEND="${DEPEND}"

SLOT="0"

GIFT_USER="gift"
GIFT_HOME="/home/${GIFT_USER}/"
GIFT_INIT="gnu-gift"

S="${WORKDIR}/${PN}"

PATCHES=(
#	${FILESDIR}/${PN}-0.1.14-noDoc.patch # should be conditional on '!use doc'
	"${FILESDIR}/${PN}-0.1.14-ps_params.patch"
#	${FILESDIR}/${PN}-0.1.14-patch-tid.patch
#	${FILESDIR}/${PN}-0.1.14-extra_qualif.patch
)

src_prepare() {
	default
#	rmdir Doc

	eautoreconf
}

src_configure() {
#	econf --enable-multithreading \
#		--enable-bayesian \
#		--datadir=/usr/share/${PN} \
#		--includedir=/usr/include/${PN} || die "econf failed"

	econf --enable-multi-threading
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README NEWS AUTHORS

	newconfd "${FILESDIR}/${PN}.confd" "${GIFT_INIT}"
	newinitd "${FILESDIR}/${PN}.initd" "${GIFT_INIT}"
}

pkg_preinst() {
	enewuser ${GIFT_USER} -1 /bin/bash ${GIFT_HOME} users
}
