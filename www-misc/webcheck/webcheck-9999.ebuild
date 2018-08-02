# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Bug #348280 -- tosubmit

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 python3_5 python3_6 )

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
	dev-python/beautifulsoup[${PYTHON_USEDEP}]
"
DEPEND="${DEPEND}
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]"
