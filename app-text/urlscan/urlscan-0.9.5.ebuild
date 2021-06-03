# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

DESCRIPTION="Extract and browse the URLs contained in an email"
HOMEPAGE="https://github.com/firecat53/urlscan https://packages.debian.org/urlscan"
SRC_URI="https://github.com/firecat53/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/urwid[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i -e "s@share/doc/urlscan@share/doc/${PF}@" setup.py || die
}

src_install() {
	distutils-r1_src_install
	doman ${PN}.1
}
