# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..13} )

inherit distutils-r1

DESCRIPTION="Up to date simple useragent faker with real world database"
HOMEPAGE="https://pypi.org/project/fake-useragent/ https://github.com/hellysmile/fake-useragent"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hellysmile/fake-useragent.git"
else
	SRC_URI="https://github.com/hellysmile/fake-useragent/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

# FIXME: We're probably missing some dependencies. But the requirements.txt
# includes a lot of dubious entries, so we'll assume none are actually required
# at runtime until proven otherwise.
RDEPEND="
	${PYTHON_DEPS}
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
"
DEPEND="test? (
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
		)"

PATCHES=( "${FILESDIR}/${PN}-1.4.0-drop-pytest-coverage.patch" )

distutils_enable_tests pytest
