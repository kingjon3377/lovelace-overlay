# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

#DISTUTILS_SINGLE_IMPL=true
#PYTHON_COMPAT=( python2_7 )
inherit distutils

DESCRIPTION="Sophisticated flash-card tool also used for long-term memory research"
HOMEPAGE="http://www.mnemosyne-proj.org/"
SRC_URI="mirror://sourceforge/${PN}-proj/${PN}/${P/2a/2}/${P/m/M}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="latex"

MY_DEPEND="latex? ( app-text/dvipng )
	dev-lang/python:2.7
	dev-python/PyQt4
	dev-python/matplotlib
	dev-python/cherrypy"

DEPEND="${DEPEND}
	${MY_DEPEND}"
RDEPEND="${RDEPEND}
	${MY_DEPEND}"

S="${WORKDIR}/${P/m/M}"

#src_prepare() {
#	if ! use latex ; then
#	sed -i \
#		-e "s/process_latex(latex_command):/process_latex(latex_command):\n    return latex_command/" \
#		mnemosyne/core/mnemosyne_core.py || die "sed failed"
#	fi
#}
