# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://salsa.debian.org/debian/${PN}.git"

inherit eutils git-r3 multilib toolchain-funcs

DESCRIPTION="The Scheme->C compiler, R4RS compliant"
HOMEPAGE="https://salsa.debian.org/debian/scheme2c"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="" #only x32 and amd64 are tested and supported
IUSE="X +doc"

DEPEND="dev-libs/libsigsegv
	   doc? ( app-text/ghostscript-gpl )
	   X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/0001-doc-pdflatex.patch" "${FILESDIR}/0002-drop-gcc-arch-native-opt.patch"
	default
}

# FIXME: Convert to real multilib
my_compile() {
	pushd "${S}/${1}" > /dev/null
	# Due to insanity in the build system we have to touch these to
	# guarantee that everything will always get built
	touch scrt/*.c scsc/*.c

	emake -j1 all USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"

	if use X; then
		emake -C cdecl USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
		emake -C xlib -B sizeof.cdecl USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
		emake -C xlib all USER_CFLAGS="${CFLAGS}" "CC=$(tc-getCC)"
	fi
	popd > /dev/null
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
	pushd "${S}/${1}" > /dev/null
	insinto /usr/$(get_libdir)/${PN}

	# Only a small subset of files from scrt is required
	doins scrt/libs2c.a scrt/predef.sc scrt/objects.h scrt/options.h

	use X && doins xlib/scxl.a
	popd > /dev/null
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
		-e "s:-LIBDIR.*t:-LIBDIR /usr/$(get_libdir)/scheme2c/ \
			   -I/usr/$(get_libdir)/scheme2c/:g" \
		-e "s:-scmh 40:-scmh 1000 -sch 10:g" "${D}/usr/bin/s2cc" || die
}
