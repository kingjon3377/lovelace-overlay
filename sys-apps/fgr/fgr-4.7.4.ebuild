# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fgr Command Find Tool"
HOMEPAGE="https://xffm.sourceforge.net/fgr.html"
SRC_URI="https://downloads.sourceforge.net/xffm/${PV}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-libs/glib-2.6.0"

# fgr is bundled with rodent
RDEPEND="${DEPEND}
	!x11-misc/rodent"

DOCS=( AUTHORS ChangeLog NEWS README TODO )
