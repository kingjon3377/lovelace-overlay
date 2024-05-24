# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Open-source wallpaper changer for Linux"
HOMEPAGE="https://peterlevi.com/variety https://github.com/varietywalls/variety"
SRC_URI="https://github.com/varietywalls/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fortune"

DEPEND="
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"

RDEPEND="
	fortune? (
		games-misc/fortune-mod
	)
	dev-python/dbus-python[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	media-libs/gexiv2[introspection]
	x11-libs/libnotify[introspection]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP},cairo]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	media-gfx/imagemagick
	dev-libs/libappindicator
"

distutils_enable_tests unittest

# tests seem to access and expect desktop configuration, and most tests require network access
RESTRICT=test

src_prepare() {
	cat >> pyproject.toml <<-EOF

[build-system]
requires = ["setuptools", "wheel", "python_distutils_extra"]
	EOF
	default
}

src_install() {
	distutils-r1_src_install
	mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}" || die
}

python_test() {
	"${EPYTHON}" -m unittest discover -p 'Test*.py' tests || die
}
