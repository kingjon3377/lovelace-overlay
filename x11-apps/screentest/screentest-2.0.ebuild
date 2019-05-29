# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utility to test the quality of screens"
HOMEPAGE="https://tobix.github.io/screentest/"
SRC_URI="https://github.com/TobiX/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-libs/glib:2"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS NEW_TESTS README )
