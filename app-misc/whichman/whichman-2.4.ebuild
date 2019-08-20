# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fault tolerant search utilities"
HOMEPAGE="http://linuxfocus.org/~guido/#whichman"
SRC_URI="http://linuxfocus.org/~guido/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( README )

# TODO: Prevent pre-stripping of binaries
