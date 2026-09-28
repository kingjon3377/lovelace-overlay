# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{1..4} )
DISTUTILS_USE_PEP517=standalone

inherit distutils-r1 pypi

DESCRIPTION="A rate limiting extension for Starlette and Fastapi"

HOMEPAGE="https://github.com/laurents/slowapi"
LICENSE="MIT"
RESTRICT="test"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="redis"
DEPENDENCIES="dev-python/limits[${PYTHON_USEDEP}]
	redis? ( <dev-python/redis-4.0.0[${PYTHON_USEDEP}] )"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"
