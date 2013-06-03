# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

RESTRICT_PYTHON_ABIS="3.*"

inherit virtualx python

PROJ="thetimelineproj"

DESCRIPTION="Timeline editing software"
HOMEPAGE="http://thetimelineproj.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PROJ}/${PROJ}/${PV}/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/markdown
	dev-python/wxpython:2.8
	dev-python/pysvg"
DEPEND="${RDEPEND}
	test? ( dev-python/mock )"

#src_test() {
#	VIRTUALX_COMMAND="./execute-specs.py"
#	virtualmake
#}

src_install() {
	insinto $(python_get_sitedir)/${PN}
	dodir $(python_get_sitedir)/${PN}
	doins -r timelinelib/ icons/
	doins ${PN}.py
	python_convert_shebangs 2.7 "${D}"/$(python_get_sitedir)/${PN}/${PN}.py
	chmod +x "${D}"/$(python_get_sitedir)/${PN}/${PN}.py
	dodir /usr/bin
	dosym $(python_get_sitedir)/${PN}/${PN}.py /usr/bin/${PN}
}
