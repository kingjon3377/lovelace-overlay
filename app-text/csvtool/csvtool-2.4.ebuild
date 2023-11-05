# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune

DESCRIPTION="a handy command line tool for handling CSV files"
HOMEPAGE="https://github.com/Chris00/ocaml-csv"
SRC_URI="https://github.com/Chris00/ocaml-csv/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/ocaml-csv-${PV}"

# TODO: We should be able to run tests, and there may be more that should be installed.
