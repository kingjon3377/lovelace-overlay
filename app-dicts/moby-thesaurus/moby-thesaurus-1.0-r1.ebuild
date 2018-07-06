# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Zrajm C Akfohg <zrajm@klingonska.org>

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

MY_P=dict-moby-thesaurus
HOMEPAGE="http://www.dcs.shef.ac.uk/research/ilash/Moby/ https://packages.debian.org/unstable/text/dict-moby-thesaurus"
SRC_URI="mirror://debian/pool/main/d/${MY_P}/${MY_P}_${PV}.orig.tar.gz"
DESCRIPTION="Grady Ward's Moby Thesaurus; 35000 root words and 2.5 million synonyms"

RDEPEND=">=app-text/dictd-1.5.5"
DEPEND="${RDEPEND}
	dev-python/dictdlib[${PYTHON_USEDEP}]
	dev-python/dictclient[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"

SLOT="0"
LICENSE="public-domain GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE=""

S="${WORKDIR}/${MY_P}-${PV}.orig"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	cp "${FILESDIR}/introduction.txt" . || die
	default
}

src_compile() {
	"${PYTHON}" "${FILESDIR}/conv.py" < mthesaur.txt
	dictzip moby-thesaurus.dict
}

src_install () {
	insinto /usr/share/dictd
	doins *.dz *.index
	dodoc aaREADME.txt
}
