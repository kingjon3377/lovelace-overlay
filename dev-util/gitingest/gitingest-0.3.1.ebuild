# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{2..4} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 # pypi

DESCRIPTION="CLI tool to analyze and create text dumps of codebases for LLMs"
HOMEPAGE="https://github.com/coderamp-labs/gitingest"
SRC_URI="https://github.com/coderamp-labs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/prometheus-client[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/sentry-sdk[${PYTHON_USEDEP}]
	dev-python/slowapi[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	dev-python/tiktoken[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/eval-type-backport[${PYTHON_USEDEP}]
	)"

PATCHES=(
	# Tests using "bitbucket" data hang until they receive input from the user (thus PROPERTIES=interactive), then fail.
	"${FILESDIR}/${P}-skip-bitbucket-tests.patch"
	# This test also hangs until it gets input, then succeeds.
	"${FILESDIR}/${P}-remove-interactive-test.patch"
)

distutils_enable_tests pytest
