# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit python multilib

DESCRIPTION="Static site builder using docutils"
HOMEPAGE="http://www.voidspace.org.uk/python/rest2web/"
SRC_URI="mirror://sourceforge/rest2web/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/docutils-0.3"

src_compile () {
	$(PYTHON) r2w.py -n
}

src_install () {
	local pkgpath="$(python_get_sitedir)"
	dodir "${pkgpath}"
	insinto "${pkgpath}"
	doins rest2web
	newbin r2w.py r2w
	newman r2w.man r2w.1
	dohtml -r docs_html/*
}

pkg_postinst () {
	python_mod_optimize "$(python_get_sitedir)/rest2web"
}

pkg_postrm () {
	python_mod_cleanup "$(python_get_sitedir)/rest2web"
}
