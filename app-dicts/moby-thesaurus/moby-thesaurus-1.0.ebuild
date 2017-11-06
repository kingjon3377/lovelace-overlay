# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Zrajm C Akfohg <zrajm@klingonska.org>

EAPI=5

inherit unpacker multilib

MY_P=dict-moby-thesaurus
DEB="${MY_P}_${PV}-6.2_all.deb"
S=${WORKDIR}
HOMEPAGE="http://www.dcs.shef.ac.uk/research/ilash/Moby/ https://packages.debian.org/unstable/text/dict-moby-thesaurus"
SRC_URI="mirror://debian/pool/main/d/${MY_P}/${DEB}"
DESCRIPTION="Grady Ward's Moby Thesaurus; 35000 root words and 2.5 million synonyms"

RDEPEND=">=app-text/dictd-1.5.5"
DEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

IUSE=""

src_install () {
	dodoc usr/share/doc/dict-moby-thesaurus/*
	dodir /usr/$(get_libdir)/dict
	insinto /usr/$(get_libdir)/dict
	doins usr/share/dictd/*
}
