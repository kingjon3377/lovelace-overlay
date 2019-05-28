# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Latin dictionary"
HOMEPAGE="https://www.geocities.ws/mfp_99/glossator.html"
SRC_URI="https://www.geocities.ws/mfp_99/gloss$(ver_rs 1- '').zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/tcl
	dev-lang/tk"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/${PN}
	doins "${WORKDIR}"/*
	fperms +x /usr/share/${PN}/${PN}.tcl
	dodir /usr/bin
	dosym ../share/${PN}/${PN}.tcl /usr/bin/${PN}
	dodoc "${FILESDIR}/documentation_from_website.html" "${FILESDIR}/AUTHORS"
}
