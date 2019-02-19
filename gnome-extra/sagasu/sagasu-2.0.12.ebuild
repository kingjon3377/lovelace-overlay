# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="GNOME tool to find strings in a set of files"
HOMEPAGE="http://sarrazip.com/dev/sagasu.html"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="gnome-base/libgnomeui
	dev-lang/perl"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/use-main-glib-h.patch" )

DOCS=( AUTHORS ChangeLog NEWS THANKS TODO )
