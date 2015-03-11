# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fdo-mime gnome2-utils

DESCRIPTION="office suite"
HOMEPAGE="http://www.softmaker.de/ofl06.htm"
SRC_URI="http://www.softmaker.net/down/charity2009/softmaker-office-2008.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"
LINGUAS="de en es fr hu pb ru tr"
IUSE=""
for lang in ${LINGUAS};do
	IUSE="${IUSE} linguas_${lang}"
done

DEPEND=""
RDEPEND=""
# Probably needs some compat libraries for amd64

S="${WORKDIR}/smoffice"

progs="textmaker planmaker presentations"
src_unpack() {
	unpack ${A}
	mkdir smoffice
	cd smoffice
	tar xzf ../office.tgz || die "unpack failed"
}

src_compile() {
	find "${WORKDIR}" -type f -print0 | xargs -0 chmod -x
	for a in de en es fr hu pb ru tr; do
		use linguas_${a} || rm -r install_${a}
		use linguas_${a} || rm -r html_${a}
	done
}

src_install() {
	DATADIR=/usr/share
	APPPATH=/usr/share/office2008
	APPBINPATH=/usr/bin
	DESKTOPPATH=/usr/share/applications
	MIMEPATH=/usr/share/mime
	GMIMEPATH=/usr/share/mime-info
	KMIMEPATH=/usr/share/mimelnk
	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	newins icons/tml_32.png textmaker.png
	newins icons/pml_32.png planmaker.png

	for a in /usr/share/icons/hicolor /usr/share/icons/gnome;do
		for size in 48 32 16;do
			for app in tmd pmd prd;do
				dosym ../../../../pixmaps/${app}_${size}.png \
					${a}/${size}x${size}/mimetypes/gnome-mime-application-x-${app}.png
			done
		done
	done

	make_desktop_entry textmaker "TextMaker" tml_48 Office \
		"Path=${APPPATH}"
	make_desktop_entry planmaker "PlanMaker" pml_48 Office \
		"Path=${APPPATH}"
	make_desktop_entry presentations "SoftMaker Presentations" prl_48 \
		Office "Path=${APPPATH}"
	doicon icons/tmd_48.png icons/pmd_48.png icons/prd_48.png || \
		icons/tmd_32.png icons/pmd_32.png icons/prd_32.png || \
		icons/tmd_16.png icons/pmd_16.png icons/prd_16.png

	insinto ${GMIMEPATH}
	doins mime/smoffice.keys mime/smoffice.mime
	insinto ${MIMEPATH}/packages
	doins mime/smoffice.xml
	insinto ${KMIMEPATH}/application
	doins mime/x-{tmd,pmd,prd,tmv,pmv,prv}.desktop
	insinto /usr/share/pixmaps
	dodir /usr/share/pixmaps
	for a in tml pml prl tmd pmd prd;do
		if [[ -f "${D}/usr/share/pixmaps/${a}_48.png" ]]; then
			dosym ${a}_48.png /usr/share/pixmaps/${a}.png
		else
			newins icons/${a}_48.png ${a}.png || die \
				"installing ${a} as main icon failed"
		fi
	done
	insinto /usr/share/application-registry
	doins mime/smoffice.applications
	rm mime/x-prv.desktop mime/x-tmd.desktop mime/x-tmv.desktop \
		mime/x-pmv.desktop mime/x-prd.desktop mime/x-pmd.desktop \
		mime/smoffice.applications icons/pml_32.png icons/prd_48.png \
		icons/tml_32.png icons/tml_48.png icons/tmd_48.png icons/pmd_48.png \
		icons/pml_48.png mime/smoffice.keys mime/smoffice.mime \
		|| die "removing files from bulk-installed directory (after individual installation) failed"
	insinto ${APPPATH}
	doins -r *
	dodir /usr/share/doc/${P}/html
	for a in de en es fr hu pb ru tr; do
		if [[ -d html_${a} ]]; then
			mv html_${a} "${D}/usr/share/doc/${P}/html/${a}" \
				|| die "installing ${a} HTML doc failed"
		fi
	done
	for prog in $progs; do
		fperms +x ${APPPATH}/${prog}
		dodir /usr/bin
		echo '#!/bin/sh' > "${D}"/usr/bin/${prog}
		echo "# A script to run the program ${prog} from SoftMaker Office" \
			>> "${D}"/usr/bin/${prog}
		echo "\"${APPPATH}\"/${prog} \"\$@\"" >> "${D}"/usr/bin/${prog}
		fperms +x /usr/bin/${prog}
	done
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
