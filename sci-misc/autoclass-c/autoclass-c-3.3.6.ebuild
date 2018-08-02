# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs versionator

DESCRIPTION="An unsupervised Bayesian classification system"
HOMEPAGE="https://ti.arc.nasa.gov/tech/rse/synthesis-projects-applications/autoclass/autoclass-c/"
SRC_URI="https://ti.arc.nasa.gov/m/project/autoclass/$(replace_all_version_separators - "${P}").tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""
DEPEND="app-shells/tcsh"
RDEPEND="${DEPEND}"

#RDEPEND=""

S=${WORKDIR}/${PN}

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
