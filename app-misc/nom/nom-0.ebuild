# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="List files except those specified"
HOMEPAGE="https://docstore.mik.ua/orelly/unix/upt/ch15_09.htm"
SRC_URI="https://www.macs.hw.ac.uk/~hwloidl/docs/UnixPowerTools/example_files/split/${PN}"

LICENSE="freedist" # apparently---no license is given in _Unix Power Tools_
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin "${PN}"
}
