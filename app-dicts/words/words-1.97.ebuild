# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ADA_COMPAT=( gcc_13 gnat_2021 gcc_12 ) # gcc_14 gcc_15

inherit ada

DESCRIPTION="Latin--English dictionary."
HOMEPAGE="http://archives.nd.edu/whitaker/words.htm"
SRC_URI="http://archives.nd.edu/whitaker/wordsall.zip"

S="${WORKDIR}"
LICENSE="words"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${ADA_DEPS}"
DEPEND="${ADA_DEPS}"
BDEPEND="app-arch/unzip"

src_compile() {
	ada_export GNATMAKE
	for a in words makedict makestem makeewds makeefil makeinfl sorter wakedict
	do
		# N.B. CFLAGS needs to be unquoted
		"${GNATMAKE}" ${CFLAGS} ${a} || die "Making ${a} failed"
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
	insinto /usr/libexec/${PN}
	doins ${PN}
	insinto /usr/share/${PN}
	doins DICTFILE.GEN UNIQUES.LAT STEMFILE.GEN INFLECTS.SEC INDXFILE.GEN \
		ADDONS.LAT EWDSFILE.GEN
	# N.B. we can't use wrapper.eclass, since it doesn't allow changing CWD before executing the binary.
	dobin "${FILESDIR}/latin"
	fperms 755 /usr/libexec/${PN}/${PN}
	dodoc HOWTO.txt "${FILESDIR}/README" wordsdoc.htm
}
