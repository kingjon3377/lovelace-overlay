# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Efficient learning tool with powerful digital flash-cards"
HOMEPAGE="https://mnemosyne-proj.org/"

SRC_URI="https://github.com/${PN}-proj/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="AGPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="latex"

# gtts = "^2.3.2" -> gTTS, in ::voyageur, ::HomeAssistantRepository, ::edgets
# google-trans-new = "^1.1.9"
DEPEND="
	>=dev-python/PyQt5-5.6[gui,widgets,${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/argon2-cffi[${PYTHON_USEDEP}]
	>=dev-python/cheroot-5.0.0[${PYTHON_USEDEP}]
	dev-python/cherrypy[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	>=dev-python/PyQtWebEngine-5.6[${PYTHON_USEDEP}]
	>=dev-python/webob-1.4.0[${PYTHON_USEDEP}]
	latex? (
		app-text/dvipng
		virtual/latex-base
	)
"
BDEPEND="dev-python/pytest-timeout[${PYTHON_USEDEP}]"

# Tests error, then hang, due to failure to access network (and will fail due
# to missing deps anyway)
RESTRICT=test

distutils_enable_sphinx mnemosyne/libmnemosyne/docs
distutils_enable_tests pytest

python_test() {
	emake -C po ../mo/de/LC_MESSAGES/mnemosyne.mo
	${EPYTHON} -m nose -v --exe tests || die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	elog ""
	elog "The text-to-speech support would be disabled since gTTS is absent in Gentoo."
	elog ""
	elog "The Google translate support would be disabled since google_trans is absent in Gentoo."
	elog ""
}
