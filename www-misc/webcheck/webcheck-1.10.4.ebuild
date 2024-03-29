# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Bug #348280 -- tosubmit

# TODO: Convert to python-r1 eclass (family)?

EAPI=7

DESCRIPTION="website link and structure checker"
HOMEPAGE="https://arthurdejong.org/webcheck/"
SRC_URI="https://arthurdejong.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/share/${PN}
	# TODO: Use either "find -exec" or "find -print0 | xargs -0"
	find -name \*.py | \
		xargs cp --parents --target-directory "${D}/usr/share/${PN}" || \
		die "installing python files failed"
	insinto /usr/share/${PN}
	doins webcheck.css favicon.ico
	insinto /usr/share/${PN}/fancytooltips
	doins fancytooltips/fancytooltips.js
	fperms 755 "/usr/share/${PN}/${PN}.py"
	dosym ../share/${PN}/${PN}.py /usr/bin/${PN}
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
