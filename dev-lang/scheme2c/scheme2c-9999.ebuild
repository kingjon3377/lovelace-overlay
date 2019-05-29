# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://salsa.debian.org/debian/${PN}.git"

# TODO: Do we really still need eutils?
inherit eutils git-r3 multilib toolchain-funcs

DESCRIPTION="The Scheme->C compiler, R4RS compliant"
HOMEPAGE="https://salsa.debian.org/debian/scheme2c"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="" #only x32 and amd64 are tested and supported
IUSE="X +doc"

DEPEND="dev-libs/libsigsegv
		X? ( x11-libs/libX11 )"
BDEPEND="doc? ( app-text/ghostscript-gpl )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/0001-doc-pdflatex.patch" "${FILESDIR}/0002-drop-gcc-arch-native-opt.patch"
)

# FIXME: Convert to real multilib
my_compile() {
	# Due to insanity in the build system we have to touch these to
	# guarantee that everything will always get built
	touch "${1}/scrt"/*.c "${1}/scsc"/*.c

	emake -C "${1}" -j1 all USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"

	if use X; then
		emake -C "${1}/cdecl" USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
		emake -C "${1}/xlib" -B sizeof.cdecl USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
		emake -C "${1}/xlib" all USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
	fi
}

src_compile() {
	use doc && \
		emake -C doc/ embedded.pdf index.pdf intro.pdf smithnotes.pdf

	if use x86; then
		emake forLINUX USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
		my_compile LINUX
	elif use amd64; then
#		if use multilib; then
#			emake forLINUX || die "Failed to set up Linux build"
#			my_compile LINUX
#		fi
		emake forAMD64 USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
		my_compile AMD64 USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
	else
		die "Unimplemented architecture"
	fi
}

my_install() {
	insinto /usr/$(get_libdir)/${PN}

	# Only a small subset of files from scrt is required
	doins "${1}/scrt/libs2c.a" "${1}/scrt/predef.sc" "${1}/scrt/objects.h" "${1}/scrt/options.h"

	use X && doins "${1}/xlib/scxl.a"
}

src_install() {
	if use x86; then
		my_install LINUX
		DIR="${S}/LINUX"
	elif use amd64; then
#		if use multilib; then
#			ABI=x86 my_install LINUX
#		fi
		my_install AMD64
		DIR="${S}/AMD64"
	else
		die "Unimplemented architecture"
	fi

	dobin "${DIR}/scrt/s2ci" "${DIR}/scsc/"{s2cc,s2ccomp}

	use X && \
		dobin "${DIR}/xlib/scixl" && \
		newdoc "${DIR}/xlib/doc.txt" xlib.txt

	cp doc/s2cc.l doc/s2cc.1 || die
	cp doc/s2ci.l doc/s2ci.1 || die
	doman doc/{s2cc,s2ci}.1

	use doc && dodoc doc/*.pdf

	dodoc CHANGES README

	sed -i -e "s:.*sccomp:sccomp:g" \
		-e "s:-LIBDIR.*t:-LIBDIR /usr/$(get_libdir)/scheme2c/ -I/usr/$(get_libdir)/scheme2c/:g" \
		-e "s:-scmh 40:-scmh 1000 -sch 10:g" "${D}/usr/bin/s2cc" || die
}
