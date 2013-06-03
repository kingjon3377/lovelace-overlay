# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils

DESCRIPTION="A wrapper generator to generate C++ mapping Java classes"
HOMEPAGE="http://www.scilab.org/giws/"
SRC_URI="http://forge.scilab.org/index.php/p/${PN}/downloads/get/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/libxml2[python]"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	dodoc -r examples
}
