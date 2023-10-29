# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1 pypi

DESCRIPTION="Python Reddit API Wrapper"
HOMEPAGE="https://pypi.org/project/praw/ https://github.com/praw-dev/praw"
comment_ids_commit=2b71773bd4f87cd2479f1fc94dfe2574220d66a5
test_files_commit=0e9d8f1ea7710a9203c83fd657a581628a946f5a
too_large_commit=17e9bec1ab02607eff6d0cf05a62d0c6ba479dd5
SRC_URI="$(pypi_sdist_url)
	https://raw.githubusercontent.com/praw-dev/praw/${comment_ids_commit}/tests/integration/files/comment_ids.txt
		-> ${PN}-7.4.0_comment_ids.txt
	https://github.com/praw-dev/praw/raw/${test_files_commit}/tests/integration/files/test.mov
		-> ${PN}-7.4.0_test.mov
	https://github.com/praw-dev/praw/raw/${test_files_commit}/tests/integration/files/test.mp4
		-> ${PN}-7.4.0_test.mp4
	https://github.com/praw-dev/praw/raw/${too_large_commit}/tests/integration/files/too_large.jpg
		-> ${PN}-7.4.0_too_large.jpg"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/websocket-client[${PYTHON_USEDEP}]
	dev-python/prawcore[${PYTHON_USEDEP}]
	dev-python/update_checker[${PYTHON_USEDEP}]"
DEPEND="test? (
			${RDEPEND}
			dev-python/betamax[${PYTHON_USEDEP}]
			dev-python/betamax-matchers[${PYTHON_USEDEP}]
		)"

src_unpack() {
	for file in $A;do
		case "${file}" in
		*tar.gz) unpack "${file}" ;;
		*) cp -av "${DISTDIR}/${file}" "${WORKDIR}" || die ;;
		esac
	done
}

src_prepare() {
	mkdir -p "${S}/tests/integration/files" || die
	for file in comment_ids.txt test.mp4 test.mov too_large.jpg;do
		cp "${WORKDIR}/${PN}-7.4.0_${file}" "${S}/tests/integration/files/${file}" || die
	done
	cp "${FILESDIR}/7.2.0_tests_integration_files"/* "${S}/tests/integration/files" || die
	mkdir -p "${S}/${PN}/images" || die
	cp "${S}/docs/logo/png/PRAW logo.png" "${S}/${PN}/images/" || die
	cp "${FILESDIR}/tests_unit_${PN}.ini" "${S}/tests/unit/${PN}.ini" || die
	default
}

distutils_enable_tests pytest
