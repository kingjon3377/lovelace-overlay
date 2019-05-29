# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Recognizes top-posted e-mail and usenet replies"
HOMEPAGE="http://www.toastfreeware.priv.at/"
SRC_URI="http://www.toastfreeware.priv.at/tarballs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+doc"

DEPEND=""
RDEPEND="${DEPEND}"

# TODO: Convert first couple of lines to DOCS=() default_src_install
src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README examples/procmailrc.example
	insinto /etc
	doins examples/fullquottelrc
	dodoc -r doc_user/html
	use doc && docinto api && dodoc -r doc_programmer/html/*
}
