# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..12} )

inherit python-r1

MY_PN=EpubMerge

# TODO: install Calibre plugin as well

# TODO: Install Qt-based UI?

DESCRIPTION="Utility to merge EPUBs"
HOMEPAGE="https://github.com/JimmXinu/EpubMerge"
SRC_URI="https://github.com/JimmXinu/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/six[${PYTHON_USEDEP}]')"
DEPEND="${PYTHON_DEPS}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=(
	"${FILESDIR}/${P}-d642d48b44065c7eff35ecebe9ad9abf56bc2137.patch"
	"${FILESDIR}/${P}-9c63aea9d87feecdd214c63f283d706d29e1407a.patch"
)

src_install() {
	newbin "${PN}.py" "${PN}"
	python_replicate_script "${ED}"/usr/bin/"${PN}"

	dodoc DESCRIPTION.rst README.md
}

test_impl() {
	"${EPYTHON}" "${PN}.py" --help || die "simplest test failed"
}

src_test() {
	python_foreach_impl test_impl
}
