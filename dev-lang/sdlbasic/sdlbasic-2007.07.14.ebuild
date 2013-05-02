# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs flag-o-matic versionator

DESCRIPTION="BASIC interpreter for game development"
HOMEPAGE="http://sdlbasic.altervista.org/main/index.php"
SRC_URI="mirror://sourceforge/${PN}/source/${delete_all_version_separators}/${PN/b/B}-src-${PV}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
	default_src_unpack
}

src_prepare() {
	mv -i ../usr/src .
	rmdir ../usr
	epatch "${FILESDIR}/sdlbasic_0.0.20070714-3.diff"
	mv -i sdlbasic-0.0.20070714/debian .
	rmdir sdlbasic-0.0.20070714
	epatch $(sed -e 's:^:debian/patches/:' debian/patches/series)
	chmod -x src/sdlBasic/share/sdlBasic/*.*
	epatch "${FILESDIR}"/warnings.patch
	sed -i -e 's:-Wl,-rpath, ::g' src/sdlBasic/src/sdlBrt/makefile \
		src/sdlBasic/src/sdlBrt/BASengine/makefile \
		src/sdlBasic/src/sdlBrt/SDLengine/makefile \
		src/sdlBasic/src/sdlBrt/unzip/makefile || die "fixing security hole failed"
	epatch "${FILESDIR}"/nostrip.patch
}

src_compile() {
	DESTBIN=/usr/bin
	DESTDOC=/usr/share/doc/${P}
	DESTDATA=/usr/share/${PN}
	DESTPLUGINS=${DESTDATA}/plugins
	ORIGSRC=${S}/src/sdlBasic/src
	ORIGDATA=${S}/src/sdlBasic/share
	XFLAGS="os=linux prefix=\"/usr\" bindir=\"${DESTBIN}\" \
		exec_prefix=\"${DESTBIN}\" datadir=\"${DESTDATA}\" \
		font_prefix=\"/usr/share/fonts/truetype\" \
		SYSCONF_PATH=\"/etc/${PN}\" DOC_PATH=\"${DESTDOC}\" \
		PLUGIN_PATH=\"${DESTPLUGINS}\" stripped=no"
	append-cxxflags -Wno-write-strings
#	append-cflags -Wno-write-strings
	cd ${ORIGSRC}/sdlBrt && sh bison_build.sh || die "bison_build failed"
	emake -C ${ORIGSRC}/sdlBasic/scintilla/gtk ${XFLAGS} \
		CFLAGS="${CFLAGS} ${CXXFLAGS}" LDFLAGS=${LDFLAGS} \
		CC="$(tc-getCXX) ${CFLAGS} ${CXXFLAGS} ${LDFLAGS}"
	emake -C ${ORIGSRC}/sdlBasic/gtk ${XFLAGS} CFLAGS="${CFLAGS} ${CXXFLAGS}" \
		LDFLAGS=${LDFLAGS} CC="$(tc-getCXX) ${CFLAGS} ${CXXFLAGS} ${LDFLAGS}"
	emake -C ${ORIGSRC}/sdlBrt/unzip ${XFLAGS} CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
	emake -C ${ORIGSRC}/sdlBrt/SDLengine ${XFLAGS} CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
	emake -C ${ORIGSRC}/sdlBrt/BASengine ${XFLAGS} CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
	emake -C ${ORIGSRC}/sdlBrt ${XFLAGS} CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		CC=$(tc-getCC)
}

src_install() {
	DESTBIN=/usr/bin
	DESTDOC=/usr/share/doc/${P}
	DESTDATA=/usr/share/${PN}
	DESTPLUGINS=${DESTDATA}/plugins
	ORIGSRC=${S}/src/sdlBasic/src
	ORIGDATA=${S}/src/sdlBasic/share/sdlBasic
	XFLAGS="os=linux prefix=\"/usr\" bindir=\"${DESTBIN}\" \
		exec_prefix=\"${DESTBIN}\" datadir=\"${DESTDATA}\" \
		font_prefix=\"/usr/share/fonts/truetype\" \
		SYSCONF_PATH=\"/etc/${PN}\" DOC_PATH=\"${DESTDOC}\" \
		PLUGIN_PATH=\"${DESTPLUGINS}\" stripped=no"
	emake -C ${ORIGSRC}/sdlBasic/gtk ${XFLAGS} install DESTDIR="${D}"
	emake -C ${ORIGSRC}/sdlBrt ${XFLAGS} install DESTDIR="${D}"
	dohtml -r -A .txt ${ORIGDATA}/../doc/sdlBasic/english/*
	dodir ${DESTDATA}
	insinto ${DESTDATA}
	doins ${ORIGDATA}/*.*
	insinto ${DESTPLUGINS}
	doins ${ORIGDATA}/plugins/*
	doman debian/*.1
}

pkg_postinst() {
	ewarn "We're probably still missing a bunch of this package, since Debian does a lot automatically."
}
