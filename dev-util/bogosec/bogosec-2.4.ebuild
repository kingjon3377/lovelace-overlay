# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib

DESCRIPTION="Source Code Security Quality Metric"
HOMEPAGE="http://launchpad.net/bogosec"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="|| ( dev-util/flawfinder dev-util/rats )
	dev-lang/perl"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:/lib/:/$(get_libdir)/:g" Makefile || die "sed failed"
}

src_install() {
	dodir "/usr/bin" "/etc" "/usr/share/man/man1"
	emake DESTDIR="${D}" install
	mv -i documents/"BogoSec TAMULUG.sxi" documents/BogoSec_TAMULUG.sxi
	dodoc README documents/Bogosec_design.doc documents/BogoSec_TAMULUG.sxi
	dohtml documents/whitepaper/*
}

pkg_postinst() {
	ewarn "Plugins are perl modules but not installed where Perl can find them; need to fix this ..."
}
