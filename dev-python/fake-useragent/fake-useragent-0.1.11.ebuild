# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="up to date simple useragent faker with real world database"
HOMEPAGE="https://pypi.org/project/fake-useragent/ https://github.com/hellysmile/fake-useragent"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# PyPI tarball doesn't include tests
RESTRICT=test

# FIXME: We're probably missing some dependencies. But the requirements.txt
# includes a lot of dubious entries, so we'll assume none are actually required
# at runtime until proven otherwise.
DEPEND="test? (
			dev-python/pytest-cov[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
		)"
RDEPEND=""
BDEPEND=""

distutils_enable_tests pytest
