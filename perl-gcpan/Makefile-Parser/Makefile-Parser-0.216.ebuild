# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR="AGENT"

inherit perl-module

DESCRIPTION="A simple parser for Makefiles"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"

DEPEND="dev-perl/Class-Accessor
	>=dev-perl/Class-Trigger-0.14
	>=perl-gcpan/Makefile-DOM-0.004
	>=dev-perl/IPC-Run3-0.043
	dev-perl/List-MoreUtils
	dev-perl/File-Slurp
	dev-lang/perl:="
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/0001-make-4.0-compatibility.patch"
	"${FILESDIR}/0002-make-4.0-fbe6e4b7f3550d0e2eaed17af0e4a21c7e7a2555.patch"
)
