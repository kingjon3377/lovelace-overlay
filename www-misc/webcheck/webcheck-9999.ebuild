# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Bug #348280 -- tosubmit

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

EGIT_REPO_URI="https://github.com/arthurdejong/webcheck.git"

inherit git-r3 distutils-r1

DESCRIPTION="website link and structure checker"
HOMEPAGE="https://arthurdejong.org/webcheck/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/utidylib[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
"
DEPEND="${DEPEND}
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]"
