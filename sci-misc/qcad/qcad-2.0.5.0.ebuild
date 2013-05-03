# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/qcad/qcad-2.0.5.0.ebuild,v 1.8 2009/01/18 22:28:25 bicatali Exp $

EAPI=5

DEPEND=">=sys-apps/sed-4"
RDEPEND=""
inherit kde-functions eutils
need-qt 3.3

manual_cs="2.0.4.0-1"
manual_de="2.1.0.0-1"
manual_en="2.1.0.0-1"
manual_hu="2.0.4.0-1"

LANGS_M="cs de en hu"

MY_P=${P}-1-community.src
PATCH_V="2.0.4.0-1.src"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A 2D CAD package based upon Qt."
# ugly hack, don't make en LINGUAS-controlled as we may need it as default
SRC_URI="http://www.ribbonsoft.com/archives/qcad/${MY_P}.tar.gz
	doc? (
		linguas_cs? ( ftp://anonymous@ribbonsoft.com/archives/qcad/qcad-manual-cs-${manual_cs}.html.zip )
		linguas_de? ( ftp://anonymous@ribbonsoft.com/archives/qcad/qcad-manual-de-${manual_de}.html.zip )
		ftp://anonymous@ribbonsoft.com/archives/qcad/qcad-manual-en-${manual_en}.html.zip
		linguas_hu? ( ftp://anonymous@ribbonsoft.com/archives/qcad/qcad-manual-hu-${manual_hu}.html.zip ) )"
HOMEPAGE="http://www.ribbonsoft.com/qcad.html"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"
KEYWORDS="amd64 x86"

LANGS="cs da de el en es et fr hu it nl no pa pl ru sk tr"
for X in ${LANGS} ; do
		IUSE="${IUSE} linguas_${X}"
done

if [[ -z "${LINGUAS}" ]]; then
	LINGUAS="en"
fi

src_prepare() {
	epatch "${FILESDIR}"/${PN}-${PATCH_V}-gentoo.patch \
		"${FILESDIR}"/${P}-doc.patch \
		"${FILESDIR}"/${PN}-${PATCH_V}-intptr.patch \
		"${FILESDIR}"/${PN}-2.0.4.0-gcc43.patch

	for file in */Makefile scripts/build_qcad.sh; do
		sed -i -e 's~qmake~${QTDIR}/bin/qmake~g' $file || \
			die "unable to correct path to qmake in $file"
	done

	echo >> "${S}"/mkspecs/defs.pro "DEFINES += _REENTRANT QT_THREAD_SUPPORT"
	echo >> "${S}"/mkspecs/defs.pro "CONFIG += thread release"
	echo >> "${S}"/mkspecs/defs.pro "QMAKE_CFLAGS_RELEASE += ${CFLAGS}"
	echo >> "${S}"/mkspecs/defs.pro "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}"

	# code does not compile with -pedantic
	sed -i -e "s:-pedantic::" "${S}"/mkspecs/defs.pro \
		|| die "failed to remove -pedantic flag"

	sed -i -e 's/^make/make ${MAKEOPTS}/' \
		-e 's/^\.\/configure/.\/configure --host=${CHOST}/' \
		"${S}"/scripts/build_qcad.sh || die
	sed -i -e "s:FULLASSISTANTPATH:${QTDIR}/bin:" \
		-e "s:QCADDOCPATH:/usr/share/doc/${PF}:" \
		"${S}"/qcad/src/qc_applicationwindow.cpp || die
}

src_compile() {
	### borrowed from kde.eclass #
	#
	# fix the sandbox errors "can't writ to .kde or .qt" problems.
	# this is a fake homedir that is writeable under the sandbox, so that the build process
	# can do anything it wants with it.
	REALHOME="$HOME"
	mkdir -p "${T}"/fakehome/.kde
	mkdir -p "${T}"/fakehome/.qt
	export HOME="$T/fakehome"
	# things that should access the real homedir
	[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"
	cd scripts
	sh build_qcad.sh || die "build failed"
	if ! test -f "${S}"/qcad/qcad; then
		die "no binary created, build failed"
	fi
	# make translations as release_translations.sh is missing
	cd ../qcad
	strip-linguas ${LANGS}
	for LANG in ${LINGUAS}; do
		lrelease src/ts/qcad_${LANG}.ts -qm qm/qcad_${LANG}.qm
	done
}

src_install () {
	cd qcad
	dodoc README
	dodir /usr/share/${PN}
	exeinto /usr/share/${PN}
	newexe ${PN} ${PN}.bin
	dodir /usr/bin
	echo -e "#!/bin/sh\ncd /usr/share/${PN}\n${PN}.bin" > "${D}"/usr/bin/${PN} \
		|| die "Failed to create wrapper"
	fperms +x /usr/bin/${PN}

	insinto /usr/share/${PN}
	doins -r patterns fonts qm

	doicon src/xpm/${PN}.xpm
	make_desktop_entry ${PN} QCad ${PN} Office

	if use doc; then
		cd "${WORKDIR}"
		strip-linguas ${LANGS_M}
		if [[ -z "${LINGUAS}" ]]; then
			ewarn "No manual translation available for your LINGUAS. Installing English."
			ewarn "Note that if you want to use it while UI set to another language, you have to symlink"
			ewarn "/usr/share/doc/${PF}/LC -> /usr/share/doc/${PF}/en"
			ewarn "(where LC is the language code of the language set for the UI)"
			LINGUAS="en"
		fi
		for LANG in ${LINGUAS}; do
			m_version=$(eval "echo \$manual_${LANG}")
			cd qcad-manual-${LANG}-${m_version}.html
			if [[ -e "index.adp" ]]; then
				ln -s index.adp qcaddoc.adp
			fi
			insinto /usr/share/doc/${PF}/${LANG}
			doins -r * || die "Failed to install manual for LINGUAS=${LANG}"
			cd ..
		done
	fi
}
