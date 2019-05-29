# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A Tool for Building Expert Systems"
HOMEPAGE="http://clipsrules.sourceforge.net/"

MY_PV="$(ver_rs 1- '' "$(ver_cut 1-2)")"
MY_PN="${PN}rules"
MY_PN2="${PN}_core_source"

SRC_URI="mirror://sourceforge/${MY_PN}/${PN}_core_source_${MY_PV}.tar.gz
	doc? (
		mirror://sourceforge/${MY_PN}/${PN}_documentation_${MY_PV}.tar.gz
		mirror://sourceforge/${MY_PN}/${PN}_examples_${MY_PV}.tar.gz )
	test? ( mirror://sourceforge/${MY_PN}/${PN}_feature_tests_${MY_PV}.tar.gz )"

LICENSE="public-domain"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="+doc test"

RDEPEND="sys-libs/ncurses:0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN2}_${MY_PV}"

# At least one test seems to hang
RESTRICT=test

src_prepare() {
	find "${WORKDIR}" -name '._*' -exec rm {} + || die
	find "${WORKDIR}" -type f -exec chmod 644 {} + || die
	if use test; then
		find "${WORKDIR}/${PN}_feature_tests_${MY_PV}" -type f \
			-exec sed -i -e 's@\r@\n@g' {} + || die
	fi
	default
}

src_compile() {
	emake -C core ${PN} CC=$(tc-getCC) LDLIBS="-lm"
}

src_test() {
	cd "${WORKDIR}/${PN}_feature_tests_${MY_PV}" || die
	for test in *tst;do
		"${S}/core/${PN}" "${test}" || die
	done
}

src_install() {
	dobin core/${PN}
	doman "${FILESDIR}/${PN}.1"
	if use doc;then
		dodoc "${WORKDIR}/${PN}_documentation_${MY_PV}"/*
		docinto examples
		dodoc -r "${WORKDIR}/${PN}_examples_${MY_PV}"/*
	fi
}
