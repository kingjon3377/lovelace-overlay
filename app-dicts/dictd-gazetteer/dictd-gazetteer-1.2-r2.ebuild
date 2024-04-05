# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=dict-gazetteer-${PV}-pre
DESCRIPTION="The original U.S. Gazetteer Place and Zipcode Files for dict"
HOMEPAGE="https://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"

S=${WORKDIR}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"

DEPEND=">=app-text/dictd-1.5.5"

src_install() {
	insinto /usr/lib/dict
	doins gazetteer.dict.dz gazetteer.index
}
