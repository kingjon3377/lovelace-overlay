# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
PYPI_NO_NORMALIZE=true
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A set of third-party serializers for Betamax"
HOMEPAGE="https://pypi.org/project/betamax-serializers/ https://gitlab.com/betamax/serializers"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/betamax[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
