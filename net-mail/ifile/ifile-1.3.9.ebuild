# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Self-learning mail sorter"
HOMEPAGE="http://qwone.com/~jason/ifile/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 amd64"

RESTRICT=test # "test suite" tests that 'make install' works properly ...

PATCHES=(
	"${FILESDIR}/05-Makefile.in.patch"
	"${FILESDIR}/20-use-debian-argp.patch"
	"${FILESDIR}/30-memset.patch"
)

src_prepare() {
	default
	sed -i '/cd $(mandir)\/man1/d' "${S}/Makefile.in" || die "sed failed"
}
