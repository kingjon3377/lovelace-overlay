# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Finds similarities between files"
HOMEPAGE="http://dickgrune.com/Programs/similarity_tester/"
SRC_URI="http://dickgrune.com/Programs/similarity_tester/sim_${PV/./_}.zip"

LICENSE="BSD"
SLOT="0"

KEYWORDS="x86 amd64"
IUSE=""
DEPEND="sys-devel/flex"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/fix-configuration.patch
}

src_install() {
	emake DESTDIR="${D}" CC="$(tc-getCC)" install
	dodoc Answers ChangeLog READ_ME README.1ST TechnReport ToDo VERSION sim.pdf
	dodoc sim.html
}
