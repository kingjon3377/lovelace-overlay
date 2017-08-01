# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit qt4-r2 eutils

DESCRIPTION="application for creating 3D structures"
HOMEPAGE="http://structuresynth.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Structure%20Synth/Version%201.5%20%28Hinxton%29/StructureSynth-Source-v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-qt/qtopengl:4
	dev-qt/qtscript:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Structure Synth Source Code"

src_configure() {
	qmake -project -after "CONFIG+=opengl" -after "QT+=xml opengl script" || die "generating project file failed"
	eqmake4
}

src_compile() {
	emake
}

src_install() {
	newbin "Structure Synth Source Code" ${PN}
	docinto examples
	dodoc Examples/*
	docinto examples/tutorials
	dodoc Examples/Tutorials/*
	insinto /usr/share/${PN}
	doins Misc/*
	domenu structure-synth.desktop
	dodoc bugs.txt BuildProcedure.txt changelog.txt notes.txt roadmap.txt
}
