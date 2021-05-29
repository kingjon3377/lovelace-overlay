# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Python Reddit API Wrapper"
HOMEPAGE="https://pypi.org/project/praw/ https://github.com/praw-dev/praw"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	https://raw.githubusercontent.com/praw-dev/praw/2b71773bd4f87cd2479f1fc94dfe2574220d66a5/tests/integration/files/comment_ids.txt -> ${P}_comment_ids.txt
	https://github.com/praw-dev/praw/raw/0e9d8f1ea7710a9203c83fd657a581628a946f5a/tests/integration/files/test.mov -> ${P}_test.mov
	https://github.com/praw-dev/praw/raw/0e9d8f1ea7710a9203c83fd657a581628a946f5a/tests/integration/files/test.mp4 -> ${P}_test.mp4
	https://github.com/praw-dev/praw/raw/17e9bec1ab02607eff6d0cf05a62d0c6ba479dd5/tests/integration/files/too_large.jpg -> ${P}_too_large.jpg"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Package claims a dependency on update_checker, but tests pass without it.
RDEPEND="dev-python/websocket-client[${PYTHON_USEDEP}]
	dev-python/prawcore[${PYTHON_USEDEP}]"
DEPEND="test? (
			${RDEPEND}
			dev-python/betamax[${PYTHON_USEDEP}]
			dev-python/betamax-matchers[${PYTHON_USEDEP}]
		)"
BDEPEND=""

src_prepare() {
	mkdir "${S}/tests/integration/files" || die
	for file in comment_ids.txt test.mp4 test.mov too_large.jpg;do
		cp "${WORKDIR}/${P}_${file}" "${S}/tests/integration/files/${file}" || die
	done
	cp "${FILESDIR}/${PV}_tests_integration_files"/* "${S}/tests/integration/files" || die
	mkdir "${S}/${PN}/images" || die
	cp "${S}/docs/logo/png/PRAW logo.png" "${S}/${PN}/images/" || die
	cp "${FILESDIR}/tests_unit_${PN}.ini" "${S}/tests/unit/${PN}.ini" || die
	default
}

distutils_enable_tests pytest
