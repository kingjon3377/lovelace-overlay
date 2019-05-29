# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a simple email archiver"
HOMEPAGE="http://adc-archmbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/adc-archmbox/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl"
BDEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )
