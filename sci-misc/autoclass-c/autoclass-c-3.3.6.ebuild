# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="An unsupervised Bayesian classification system"
HOMEPAGE="https://ti.arc.nasa.gov/tech/rse/synthesis-projects-applications/autoclass/autoclass-c/"
SRC_URI="https://ti.arc.nasa.gov/m/project/autoclass/${PN}-$(ver_rs 1- -).tar.gz"
S=${WORKDIR}/${PN}
LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ~x86"
RDEPEND="app-shells/tcsh"
BDEPEND="app-shells/tcsh"

src_compile() {
#	chmod +x load-ac || die
#	./load-ac || die
	cd "${S}/prog" || die "cd failed"
	emake -f autoclass.make
	emake CFLAGS="${CFLAGS}" CC=$(tc-getCC) -f autoclass.make.linux.gcc
}

src_install() {
	dobin ${PN}
	dodoc doc/*
	dodoc -r sample
	insinto /usr/share/${PN}
	doins -r data
}
