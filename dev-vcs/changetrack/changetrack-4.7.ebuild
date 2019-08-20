# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="monitor changes to (configuration) files"
HOMEPAGE="http://changetrack.sourceforge.net"
SRC_URI="http://changetrack.sourceforge.net/change${PV/./_}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/File-NCopy"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	: # Do nothing ... but we don't want to repeat tests, which are the first item in the Makefile.
}

src_test() {
	emake test
}

src_install() {
	dobin ${PN}
	newman ${PN}.man ${PN}.1
	insinto /etc
	doins ${PN}.conf
	dodoc README
}

pkg_postinst() {
	einfo "Inspect and adjust the configuration file, then add a cron job. This"
	einfo "package does not yet create a cron job for you."
}
