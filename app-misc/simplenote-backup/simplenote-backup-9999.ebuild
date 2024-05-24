# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..13} )

inherit python-single-r1 git-r3

DESCRIPTION="Backup utility for the Simplenote Web service"
HOMEPAGE="https://github.com/hiroshi/simplenote-backup"
EGIT_REPO_URI="https://github.com/hiroshi/simplenote-backup.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/simperium-python[${PYTHON_USEDEP}]
	')"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}/add_shebang.patch"
	"${FILESDIR}/python3.patch"
)

src_compile() {
	# Do nothing; the Makefile runs the script
	:
}

src_install() {
	python_doscript ${PN}.py
	dodoc README.md
}
