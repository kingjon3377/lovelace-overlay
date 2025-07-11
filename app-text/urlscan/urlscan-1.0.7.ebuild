# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Extract and browse the URLs contained in an email"
HOMEPAGE="https://pypi.org/project/urlscan/ https://github.com/firecat53/urlscan"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/urwid[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( README.md )
PATCHES=( "${FILESDIR}/${PN}-1.0.0-respect-paths.patch" )
