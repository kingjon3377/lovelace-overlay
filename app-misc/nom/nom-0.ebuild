# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="List files except those specified"
HOMEPAGE="http://docstore.mik.ua/orelly/unix/upt/ch15_09.htm"
SRC_URI="http://www.macs.hw.ac.uk/~hwloidl/docs/UnixPowerTools/example_files/split/${PN}"

LICENSE="freedist" # apparently---no license is given in _Unix Power Tools_
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin "${PN}"
}
