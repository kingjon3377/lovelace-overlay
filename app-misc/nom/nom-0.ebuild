# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="List files except those specified"
HOMEPAGE="http://docstore.mik.ua/orelly/unix/upt/ch15_09.htm"
SRC_URI="http://www.macs.hw.ac.uk/~hwloidl/docs/UnixPowerTools/example_files/split/${PN}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin "${PN}"
}
