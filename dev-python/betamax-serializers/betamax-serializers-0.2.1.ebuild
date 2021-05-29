# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="A set of third-party serializers for Betamax"
HOMEPAGE="https://pypi.org/project/betamax-serializers/ https://gitlab.com/betamax/serializers"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="dev-python/betamax[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
BDEPEND=""
