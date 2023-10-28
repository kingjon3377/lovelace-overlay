# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Markdown extension making lists truly sane (e.g. nesting)"
HOMEPAGE="https://github.com/radude/mdx_truly_sane_lists"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/markdown[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
