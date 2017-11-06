# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit perl-app bash-completion-r1

DESCRIPTION="command line issue tracker"
HOMEPAGE="https://github.com/chilts/cil"
SRC_URI="https://github.com/chilts/cil/archive/v0.07.00.tar.gz -> ${P}.tar.gz"
#SRC_URI="mirror://github/chilts/${PN}/archive/v0.07.00.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-perl/Class-Accessor
	dev-perl/DateTime
	dev-perl/Email-Date
	dev-perl/Email-Find
	dev-perl/Email-Simple
	dev-perl/File-Slurp
	perl-gcpan/File-Touch
	dev-perl/Getopt-Mixed
	virtual/perl-MIME-Base64"
DEPEND="dev-perl/Module-Build"

src_install() {
	perl-module_src_install
	dobashcomp etc/bash_completion.d/cil
	dodoc README
}
