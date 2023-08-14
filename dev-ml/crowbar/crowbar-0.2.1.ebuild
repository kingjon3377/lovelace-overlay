# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Write tests, let a fuzzer find failing cases"
HOMEPAGE="https://github.com/stedolan/crowbar"
SRC_URI="https://github.com/stedolan/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +ocamlopt test"
RESTRICT="!test? ( test )"

# TODO: Maybe (some) test/doc dependencies should be BDEPEND instead?
RDEPEND="dev-ml/ocplib-endian:=
	dev-ml/cmdliner
	dev-ml/afl-persistent
	"
DEPEND="${DEPEND}
	test? (
		dev-ml/calendar
		dev-ml/fpath
		dev-ml/pprint
		dev-ml/uucp
		dev-ml/uunf
		dev-ml/uutf
	)
	doc? ( dev-ml/odoc )"
BDEPEND=""
