# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright open-overlay 2015 by Alex

EAPI=5

inherit eutils versionator

SR_PV="$(get_version_component_range 3)"
SR_PV_EXTRA="$(get_version_component_range 4)"
if [[ -n ${SR_PV} ]] && [[ ${SR_PV} != 0 ]]; then
	if [[ -n "${SR_PV_EXTRA}" ]]; then
		SR=SR${SR_PV}${SR_PV_EXTRA}
	else
		SR=SR${SR_PV}
	fi
else
	SR=R
fi
RNAME="mars"

SRC_BASE="http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${RNAME}/${SR}/eclipse-java-${RNAME}-${SR}-linux-gtk"

DESCRIPTION="Eclipse SDK"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz&r=1 -> ${P}-x86_64.tar.gz )
	x86? ( ${SRC_BASE}.tar.gz&r=1 -> ${P}.tar.gz )"

LICENSE="EPL-1.0"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=virtual/jdk-1.6
	x11-libs/gtk+:2"

S=${WORKDIR}/eclipse

src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	dohtml -r readme/*

	cp "${FILESDIR}"/eclipserc-bin "${T}" || die
	cp "${FILESDIR}"/eclipse-bin "${T}" || die
	sed -i -e "s/^SLOT=\"[^\"]*\"$/SLOT=\"${SLOT}\"/" "${T}"/eclipse{,rc}-bin \
			-e "s/bin-4.2/bin-${SLOT}/" || die

	insinto /etc
	newins "${T}"/eclipserc-bin eclipserc-bin-${SLOT}

	newbin "${T}"/eclipse-bin eclipse-bin-${SLOT}
	make_desktop_entry "eclipse-bin-${SLOT}" "Eclipse ${PV} (bin)" "${dest}/icon.xpm"
}
