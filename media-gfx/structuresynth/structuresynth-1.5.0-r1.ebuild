# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils

DESCRIPTION="application for creating 3D structures"
HOMEPAGE="http://structuresynth.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Structure%20Synth/Version%201.5%20%28Hinxton%29/StructureSynth-Source-v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/qtopengl:5
	dev-qt/qtscript:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	media-libs/freeglut"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/Structure Synth Source Code"

PATCHES=(
	"${FILESDIR}/${P}-qt5-part1.patch"
	"${FILESDIR}/${P}-qt5-part2.patch"
	"${FILESDIR}/${P}-type-punning.patch"
)

src_prepare() {
	default
	sed -i -e 's@"glut.h"@<GL/glut.h>@' SyntopiaCore/GLEngine/Sphere.h \
		SyntopiaCore/GLEngine/Raytracer/RayTracer.cpp || die
}

src_configure() {
	eqmake5
}

src_install() {
	dobin ${PN}
	docinto examples
	dodoc Examples/*
	docinto examples/tutorials
	dodoc Examples/Tutorials/*
	insinto /usr/share/${PN}
	doins Misc/*
	domenu structure-synth.desktop
	dodoc bugs.txt changelog.txt notes.txt roadmap.txt
	# TODO: do something about ${S}/images ?
}
