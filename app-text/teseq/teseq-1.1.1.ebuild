# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Renders terminal typescripts human-readable"
HOMEPAGE="https://www.gnu.org/software/teseq/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-libs/check )"

src_install() {
	emake DESTDIR="${D}" install
}
