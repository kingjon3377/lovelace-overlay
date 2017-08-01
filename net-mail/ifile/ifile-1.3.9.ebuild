# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Self-learning mail sorter"
HOMEPAGE="http://people.csail.mit.edu/jrennie/ifile"
SRC_URI="https://launchpad.net/ubuntu/maverick/+source/${PN}/${PV}-1/+files/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 amd64"

src_prepare() {
	epatch "${FILESDIR}/05-Makefile.in.patch" "${FILESDIR}/20-use-debian-argp.patch"
	sed -i '/cd $(mandir)\/man1/d' "${S}/Makefile.in" || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install
}
