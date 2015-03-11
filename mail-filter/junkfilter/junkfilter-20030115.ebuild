# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="A junk-email filtering program for procmail"
HOMEPAGE="http://junkfilter.zer0.org/"
SRC_URI="http://junkfilter.zer0.org/pkg/current/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="mail-filter/procmail"

S="${WORKDIR}/${PN}"

src_compile() {
	emake JFDIR=. JFUSERDIR=.
}

src_install() {
	dodir /usr/share/${PN} /usr/$(get_libdir)
	insinto /usr/share/${PN}
	rm junkfilter.four.orig
	doins jf* junkfilter*
	dodoc README README.DEVELOPERS TODO
	docinto examples
	dodoc procmailrc.sample
	dosym ../share/${PN} "/usr/$(get_libdir)/${PN}"
}
