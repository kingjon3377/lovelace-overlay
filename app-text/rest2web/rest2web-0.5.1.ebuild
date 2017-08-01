# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-r1 multilib

DESCRIPTION="Static site builder using docutils"
HOMEPAGE="http://www.voidspace.org.uk/python/rest2web/"
SRC_URI="mirror://sourceforge/rest2web/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/docutils-0.3[${PYTHON_USEDEP}]"

python_compile() {
	${PYTHON} r2w.py -n
}

src_compile() {
	python_foreach_impl python_compile
}

each_install() {
	python_export PYTHON_SITEDIR
	dodir "${PYTHON_SITEDIR}"
	insinto "${PYTHON_SITEDIR}"
	doins -r rest2web
	python_newscript r2w.py r2w
}

src_install() {
	python_foreach_impl each_install
	newman r2w.man r2w.1
	dohtml -r docs_html/*
}
