# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs flag-o-matic

DESCRIPTION="BASIC interpreter for game development"
HOMEPAGE="http://sdlbasic.altervista.org/main/index.php"
SRC_URI="https://downloads.sourceforge.net/${PN}/source/$(ver_rs 1- '')/${PN/b/B}-src-${PV}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
	default_src_unpack
	cd "${S}"
	mv ../usr/* . || die
	rmdir ../usr || die
}

src_prepare() {
	mkdir debian
	cp "${FILESDIR}/${PN}.menu" "${FILESDIR}/copyright" \
		"${FILESDIR}/${PN}.xpm" "${FILESDIR}/${PN}.desktop" \
		debian || die
	for file in makefiles fonts 64bit fix_example ldflags datadir \
			bison_code x-www-browser quickhelp; do
		eapply "${FILESDIR}/${file}.patch"
	done
	chmod -x src/sdlBasic/share/sdlBasic/*.*
	eapply "${FILESDIR}"/warnings.patch
	sed -i -e 's:-Wl,-rpath, ::g' src/sdlBasic/src/sdlBrt/makefile \
		src/sdlBasic/src/sdlBrt/BASengine/makefile \
		src/sdlBasic/src/sdlBrt/SDLengine/makefile \
		src/sdlBasic/src/sdlBrt/unzip/makefile || die "fixing security hole failed"
	eapply "${FILESDIR}"/nostrip.patch
	eapply_user
}

src_compile() {
	DESTBIN=/usr/bin
	DESTDOC=/usr/share/doc/${PF}
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
	DESTDOC=/usr/share/doc/${PF}
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
	docinto html
	dodoc -r ${ORIGDATA}/../doc/sdlBasic/english/*
	insinto ${DESTDATA}
	doins ${ORIGDATA}/*.*
	insinto ${DESTPLUGINS}
	doins ${ORIGDATA}/plugins/*
	doman "${FILESDIR}"/*.1 debian/*.1
}

pkg_postinst() {
	ewarn "We're probably still missing a bunch of this package, since Debian does a lot automatically."
}
