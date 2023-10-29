# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Source Code Security Quality Metric"
HOMEPAGE="https://launchpad.net/bogosec"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="amd64"

DEPEND="|| ( dev-util/flawfinder dev-util/rats )"
BDEPEND="dev-lang/perl"

RDEPEND="${DEPEND}
	dev-lang/perl"

src_prepare() {
	sed -i -e "s:/lib/:/$(get_libdir)/:g" Makefile || die "sed failed"
	default
}

src_install() {
	dodir "/usr/bin" "/etc" "/usr/share/man/man1"
	emake DESTDIR="${D}" install
	newdoc documents/"BogoSec TAMULUG.sxi" BogoSec_TAMULUG.sxi
	dodoc -r README documents/Bogosec_design.doc documents/whitepaper/*
}

pkg_postinst() {
	ewarn "Plugins are perl modules but not installed where Perl can find them; need to fix this ..."
}
