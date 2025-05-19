# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dustin/go-humanize v1.0.1"
	"github.com/dustin/go-humanize v1.0.1/go.mod"
	"github.com/hebcal/gematriya v1.0.1"
	"github.com/hebcal/gematriya v1.0.1/go.mod"
	"github.com/hebcal/greg v1.0.0/go.mod"
	"github.com/hebcal/greg v1.0.1/go.mod"
	"github.com/hebcal/greg v1.0.2"
	"github.com/hebcal/greg v1.0.2/go.mod"
	"github.com/hebcal/hdate v1.1.0/go.mod"
	"github.com/hebcal/hdate v1.2.0"
	"github.com/hebcal/hdate v1.2.0/go.mod"
	"github.com/hebcal/hebcal-go v0.10.2"
	"github.com/hebcal/hebcal-go v0.10.2/go.mod"
	"github.com/hebcal/hebcal-go v0.10.3"
	"github.com/hebcal/hebcal-go v0.10.3/go.mod"
	"github.com/nathan-osman/go-sunrise v1.1.0"
	"github.com/nathan-osman/go-sunrise v1.1.0/go.mod"
	"github.com/pborman/getopt/v2 v2.1.0"
	"github.com/pborman/getopt/v2 v2.1.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/objx v0.5.2/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.1/go.mod"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

DESCRIPTION="perpetual Jewish calendar"
HOMEPAGE="http://hebcal.github.io/ https://github.com/hebcal/hebcal"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

# github.com/dustin/go-humanize: MIT
# github.com/hebcal/gematriya: BSD-2
# github.com/hebcal/greg: GPL-2.0
# github.com/hebcal/hdate: GPL-2.0
# github.com/hebcal/hebcal: GPL-2.0
# github.com/hebcal/hebcal-go: GPL-2.0
# github.com/nathan-osman/go-sunrise: MIT
# github.com/pborman/getopt/v2: BSD-3
LICENSE="GPL-2 MIT BSD-2 BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

DOCS=( AUTHORS NEWS.md README.md )

src_compile() {
	emake all "PREFIX=${EPREFIX}/usr"
}

src_test() {
	emake check
}

src_install() {
	emake install PREFIX="${ED}/usr"
}
