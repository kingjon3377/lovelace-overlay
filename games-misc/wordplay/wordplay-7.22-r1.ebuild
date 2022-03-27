# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="anagram generator"
HOMEPAGE="https://packages.debian.org/wordplay"
SRC_URI="mirror://debian/pool/main/w/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/w/${PN}/${PN}_${PV}-21.debian.tar.xz"

LICENSE="wordplay"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="app-arch/xz-utils"

S="${WORKDIR}/${P}.orig"

src_prepare() {
	mv "${WORKDIR}/debian" "${S}/debian" || die
	sed -i -e 's@/usr/share/games@/usr/share@' debian/patches/wordlist_location.patch || die
	while read -r line;do
		eapply "debian/patches/${line}"
	done < debian/patches/series
	default
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin ${PN}
	doman debian/${PN}.1
	insinto "/usr/share/wordplay"
	doins words721.txt
}
