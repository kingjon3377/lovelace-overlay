# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/td-e/t-e}
MY_P=${MY_PN}_$(ver_rs 0- '')
DESCRIPTION="Jay Kominek's database of the elements for dict"
HOMEPAGE="https://www.dict.org/ https://git.alteholz.dev/alteholz/dict-elements https://packages.debian.org/dict-elements"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${MY_PN}/${MY_P}.orig.tar.xz
	mirror://debian/pool/main/${PN:0:1}/${MY_PN}/${MY_P}-1.debian.tar.xz"

S=${WORKDIR}/${MY_P/_/-}
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-text/dictd-1.13.0-r3"
BDEPEND="${RDEPEND}
	app-arch/xz-utils"

src_compile() {
	dictfmt -p -u 'http://www.miranda.org/~jkominek/elements' \
		-s "Jay Kominek's Elements database (version $PV)" \
		--headword-separator " " \
		--columns 80 \
		-p elements \
		< elements || die
	dictzip elements.dict || die
}

src_install() {
	insinto /usr/share/dict
	doins elements.dict.dz elements.index
	newdoc ../debian/changelog ChangeLog.Debian
}
