# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1 eutils autotools

DESCRIPTION="Paco is a source code package organizer"
HOMEPAGE="http://porg.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+gtk nls"

RDEPEND="gtk? ( dev-cpp/gtkmm:3.0 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}/fix-double-destdir.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	flags="--enable-static=no"
	use gtk || flags="${flags} --disable-grop"
	econf ${flags}
}

src_install() {
	emake DESTDIR="${D}" datadir=/usr/share install
	prune_libtool_files
	dodoc AUTHORS ChangeLog README doc/faq.txt doc/${PN}rc
	docinto html
	dodoc doc/*.html doc/*.png
	rm "${D}/usr/share/${PN}/"{${PN}rc,README,faq.txt,index.html,download.png,${PN}.png} || die
	rmdir "${D}/usr/share/${PN}" || die
	newbashcomp scripts/porg_bash_completion porg
}
