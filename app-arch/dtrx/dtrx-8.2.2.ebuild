# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit readme.gentoo-r1 distutils-r1

DESCRIPTION="intelligently extract multiple archive types"
HOMEPAGE="https://github.com/dtrx-py/dtrx"
SRC_URI="https://github.com/${PN}-py/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# Fails a test dealing with a Zip file named .tar.gz; TODO: report upstream
RESTRICT=test

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		app-arch/arj
		app-arch/lha
	)"

DOC_CONTENTS="Additional packages may need to be installed, depending on the archive type."

# TODO: generate man page
python_test() {
	"${EPYTHON}" tests/compare.py || die
}

src_install() {
	default
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
