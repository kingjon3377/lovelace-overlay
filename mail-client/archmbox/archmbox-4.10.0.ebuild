# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a simple email archiver"
HOMEPAGE="https://adc-archmbox.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/adc-archmbox/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-lang/perl"
BDEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )
