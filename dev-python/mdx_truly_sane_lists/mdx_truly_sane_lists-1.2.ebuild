# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
# PEP517 mode not tested, but this is now required for Manifest generation of
# any version
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Markdown extension making lists truly sane (e.g. nesting)"
HOMEPAGE="https://github.com/radude/mdx_truly_sane_lists"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/markdown[${PYTHON_USEDEP}]"
