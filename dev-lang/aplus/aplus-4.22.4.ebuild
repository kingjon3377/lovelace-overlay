# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# From Gentoo bug #132018

EAPI=6

inherit desktop versionator elisp-common autotools virtualx

MY_PV=$(replace_version_separator 2 '-' ${PV})
MY_P=${PN}-fsf-${MY_PV}

PATCH_V=-5

DESCRIPTION="A+ is an array-oriented programming language"
HOMEPAGE="http://www.aplusdev.org"
SRC_URI="http://www.aplusdev.org/Download/${MY_P}.tar.gz"
#SRC_URI="mirror://debian/pool/main/a/aplus-fsf/aplus-fsf_${PV}.orig.tar.gz
#	mirror://debian/pool/main/a/aplus-fsf/aplus-fsf_${PV}${PATCH_V}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="emacs"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-fsf-${PV/22.4/22}

SITEFILE=50aplus-gentoo.el

# Tests fail---the GUI tests because they can't find fonts---but we want to
# install anyway, as part of switching from per-machine overlays to a shared
# overlay.
RESTRICT=test

pkg_setup() {
	# make sure we get no collisions
	# setup is not the nicest place, but preinst doesn't cut it
	for i in /usr/share/fonts/truetype/public/aplus \
		/usr/share/fonts/pcf/public/aplus
	do
	    [[ -e "${i}/fonts.cache-1" ]] && rm -f "${i}/fonts.cache-1"
	done
}

PATCHES=(
	"${FILESDIR}/00constness.patch"
	"${FILESDIR}/01_link.patch"
	"${FILESDIR}/03_el.patch"
	"${FILESDIR}/04_from_ubuntu.patch"
	"${FILESDIR}/04_makefile.in.patch"
	"${FILESDIR}/06_pthread.patch"
	"${FILESDIR}/07_magic_numbers.patch"
	"${FILESDIR}/08_cxs.patch"
	"${FILESDIR}/09_shadowed.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	default
	find . -name Makefile -exec sed -i -e 's:-L -lX11:-lX11:' {} + || die
}

src_compile () {
	emake

	if use emacs ; then
	    pushd src/lisp.1 > /dev/null
	    elisp-compile *.el
	    popd > /dev/null
	fi
}

src_test() {
	src/main/aplus ./src/acore/fsftest.+ || die

	virtx src/main/aplus src/acore/apter.+ || die
}

src_install () {
	emake install \
		DESTDIR="${D}" \
		contribdir=/usr/share/doc/${PF}/contrib \
		scriptsdir=/usr/share/doc/${PF}/scripts \
		appdefaultsdir=/etc/X11/app-defaults \
		a_includedir=/usr/include/aplus \
		TrueTypedir=/usr/share/fonts/truetype/public/aplus \
		fonts_pcfdir=/usr/share/fonts/pcf/public/aplus \
		fonts_bdfdir=/usr/share/fonts/pcf/public/aplus

#	    idapdir=/usr/$(get_libdir)/aplus \
#	    fsftestdir=/usr/$(get_libdir)/aplus \
#	    apterdir=/usr/$(get_libdir)/aplus \
#	    tdir=/usr/$(get_libdir)/aplus \
#	    diodir=/usr/$(get_libdir)/aplus \
#	    sdir=/usr/$(get_libdir)/aplus \

	cd "${D}/usr/share/fonts/pcf/public/aplus"
	mkfontdir \
		-e /usr/share/fonts/encodings \
		-e /usr/share/fonts/encodings/large \
		"${D}/usr/share/fonts/pcf/public/aplus"
	cat Kapl.alias >> fonts.alias

	cd "${D}/usr/share/fonts/truetype/public/aplus"
	mkfontscale "${D}/usr/share/fonts/truetype/public/aplus"
	mkfontdir \
		-e /usr/share/fonts/encodings \
		-e /usr/share/fonts/encodings/large \
		"${D}/usr/share/fonts/truetype/public/aplus"
#	HOME="/root" fc-cache -f ${D}/usr/share/fonts/truetype/public/aplus

	cd "${S}"

	dobin "${FILESDIR}/a+term"
	mv "${D}/etc/X11/app-defaults/XTerm" "${D}/etc/X11/app-defaults/AplusTerm"
	sed -i -e "s:XTerm\*:\*:g" "${D}/etc/X11/app-defaults/AplusTerm"

	rm -rf "${D}"/usr/lisp.?

	if use emacs ; then
	    pushd "${S}"
	    elisp-install aplus src/lisp.1/*.{el,elc}
	    elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	    popd
	fi

	dodoc ANNOUNCE AUTHORS ChangeLog INSTALL NEWS README
	mv -i "${D}/usr/doc/html" "${D}/usr/share/doc/${PF}/html"
	make_desktop_entry /usr/bin/a+ aplus-fsf "" "Applications/Programming"
	doman "${FILESDIR}"/a+.1
	dodoc "${FILESDIR}"/aplus-fsf-el.README.Debian
}

pkg_postinst () {
	use emacs && elisp-site-regen
	chkfontpath -q -a /usr/share/fonts/pcf/public/aplus
}

pkg_postrm () {
	use emacs && elisp-site-regen
	chkfontpath -r /usr/share/fonts/pcf/public/aplus
}
