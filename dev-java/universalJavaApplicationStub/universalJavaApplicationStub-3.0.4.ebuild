# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A shell script to make Mac .app bundles compatible with various Java versions"
HOMEPAGE="https://github.com/tofi86/universalJavaApplicationStub"
SRC_URI="https://github.com/tofi86/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="virtual/jre:*
	app-shells/bash:*"
DEPEND=""

RESTRICT=test # tests have never worked, and don't actually test the code that is installed

src_test() {
	"${S}/test/java-version-tester.sh" | tee "${T}/test-output.txt"
	if grep -q FAILED "${T}/test-output.txt"; then
		eerror "Test failed:"
		grep FAIL "${T}/test-output.txt"
		die "Test failed"
	fi
	# TODO: Run shellcheck, as the Travis config does?
}

src_install() {
	insinto /usr/share/${PN}
	doins src/${PN}
	dodoc CHANGELOG.md README.md docs/*png
}
