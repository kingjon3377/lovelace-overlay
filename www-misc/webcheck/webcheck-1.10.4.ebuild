# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
# Bug #348280 -- tosubmit
# FIXME: install properly under Python paths. The README explicitly supports
# this.

EAPI=5

DESCRIPTION="website link and structure checker"
HOMEPAGE="http://arthurdejong.org/webcheck/"
SRC_URI="http://arthurdejong.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/share/${PN}
	find -name \*.py | xargs cp --parents --target-directory "${D}/usr/share/${PN}" || die "installing python files failed"
	insinto /usr/share/${PN}
	doins webcheck.css favicon.ico
	insinto /usr/share/${PN}/fancytooltips
	doins fancytooltips/fancytooltips.js
	fperms 755 "/usr/share/${PN}/${PN}.py"
	dosym ../share/${PN}/${PN}.py /usr/bin/${PN}
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
