# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Latin--English dictionary."
HOMEPAGE="http://archives.nd.edu/whitaker/words.htm"
SRC_URI="http://archives.nd.edu/whitaker/wordsall.zip"

LICENSE="words"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="!app-dicts/words-bin"
DEPEND="|| ( virtual/gnat dev-lang/gnat-gpl )"

S="${WORKDIR}"

src_compile() {
	for a in words makedict makestem makeewds makeefil makeinfl sorter wakedict
	do
		gnatmake ${CFLAGS} ${a} || die "Making ${a} failed"
	done
	echo G | ./wakedict || die "Making dict failed."
	./sorter <<- ENDHERE
		STEMLIST.GEN
		1	18	U
		20	24	P
		1	18	C
		1	56	A
		58	1	D
		STEMLIST.GEN
		ENDHERE
	echo G | ./makestem || die "Making stem failed."
	echo G | ./makeewds || die
	./sorter <<- ENDHERE
		EWDSLIST.GEN
		1	24	A
		1	24	C
		51	6	R
		72	5	N	D
		58	1	D
		EWDSLIST.GEN
		ENDHERE
	./makeefil || die
	./makeinfl > /dev/null || die
}

src_install() {
	dodir /usr/libexec/${PN}
	insinto /usr/libexec/${PN}
	doins ${PN}
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins DICTFILE.GEN UNIQUES.LAT STEMFILE.GEN INFLECTS.SEC INDXFILE.GEN \
		ADDONS.LAT EWDSFILE.GEN
	dohtml wordsdoc.htm
	dobin "${FILESDIR}/latin"
	fperms 755 /usr/libexec/${PN}/${PN}
	dodoc HOWTO.txt "${FILESDIR}/README"
}
