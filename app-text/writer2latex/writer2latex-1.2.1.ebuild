# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

OFFICE_EXTENSIONS=("writer2latex.oxt" "xhtml-config-sample.oxt" "writer2xhtml.oxt")

inherit eutils latex-package java-pkg-2 java-ant-2 multilib office-ext-r1

IS_SOURCE=true

MY_PV=${PV//./}
MY_PV=${MY_PV/_/}

REV=172

if [[ -n ${IS_SOURCE} ]]
then
	MY_P=${PN}${MY_PV}source
else
	MY_P=${PN}${MY_PV}
fi

DESCRIPTION="Writer2Latex (w2l) - converter from OpenDocument .odt format"
HOMEPAGE="http://writer2latex.sourceforge.net"
#SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
SRC_URI="http://sourceforge.net/code-snapshots/svn/w/wr/writer2latex/code/${PN}-code-${REV}-tags-${PV}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

DEPEND=">=virtual/jdk-1.5
	virtual/latex-base"
RDEPEND=">=virtual/jre-1.5"

#S=${WORKDIR}/${PN}10
S=${WORKDIR}/${PN}-code-${REV}-tags-${PV}
if [[ -n ${IS_SOURCE} ]]
then
	S_DISTRO=${S}/source/distro
	S_TARGETLIB=${S}/target/lib
else
	S_DISTRO=${S}
	S_TARGETLIB=${S}
fi

OOO_EXTENSIONS="writer2latex.oxt writer2xhtml.oxt xhtml-config-sample.oxt"

# EANT_EXTRA_ARGS="-DOFFICE_HOME=/usr/lib/openoffice"
EANT_EXTRA_ARGS="-DOFFICE_HOME=${S}"
EANT_BUILD_TARGET="all"

src_prepare(){
	sed -i -e "s:W2LPATH=.*:W2LPATH=/usr/$(get_libdir)/${PN}:" ${S_DISTRO}/w2l || die "Sed failed"
	sed -i -e "/URE_CLASSES/s:/usr/share/java:/usr/$(get_libdir)/libreoffice/program/classes/:" \
		-e "/OFFICE_CLASSES/s:/usr/share/java:/usr/$(get_libdir)/libreoffice/program/classes/:" build.xml || die
}

src_install() {
	java-pkg_jarinto /usr/$(get_libdir)/${PN}
	java-pkg_dojar "${S_TARGETLIB}/${PN}.jar"

	dobin ${S_DISTRO}/w2l

	insinto /usr/$(get_libdir)/${PN}
	doins ${S_DISTRO}/xslt/*.xsl

	cd ${S_DISTRO}/latex
	latex-package_src_install

	cd ${S_DISTRO}
	dodoc History.txt Readme.txt changelog.txt

	if [[ -n ${IS_SOURCE} ]]; then
		dodoc "${S}"/source/oxt/xhtml-config-sample/config/*
	else
		dodoc "${S}"/samples/config/*
	fi

	# Work around change in eclass
	for ext in ${OFFICE_EXTENSIONS[@]}; do
		mkdir "${WORKDIR}/${ext}" || die
		if [[ -n ${IS_SOURCE} ]]; then
			ln "${S}/target/lib/${ext}" "${WORKDIR}/${ext}" || die
		else
			ln "${S}/${ext}" "${WORKDIR}/${ext}" || die
		fi
	done

	if [[ -n ${IS_SOURCE} ]]; then
		pushd "${S}/target/lib" > /dev/null || die
		office-ext-r1_src_install
		popd > /dev/null || die
	else
		office-ext-r1_src_install
	fi

	if use doc; then
	#	dohtml -r doc
		cd ${S_DISTRO}
		cp doc/* "${D}"/usr/share/doc/${PF} || die "Failed to copy .odts"
		if [[ -n ${IS_SOURCE} ]]; then
			java-pkg_dojavadoc "${S}/target/javadoc"
		fi
	fi

	if use examples; then
		cd ${S_DISTRO}
		cp -R samples "${D}"/usr/share/doc/${PF} || die "Failed to copy samples"
	fi
}
