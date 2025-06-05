# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

MY_PN=EpubMerge

# TODO: install Calibre plugin as well

# TODO: Install Qt-based UI?

DESCRIPTION="Utility to merge EPUBs"
HOMEPAGE="https://github.com/JimmXinu/EpubMerge"
SRC_URI="https://github.com/JimmXinu/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="$(python_gen_cond_dep 'dev-python/six[${PYTHON_USEDEP}]')"

DOCS=( DESCRIPTION.rst README.md )

python_test() {
	"${EPYTHON}" "${PN}/${PN}.py" --help || die "simplest test failed"
}
