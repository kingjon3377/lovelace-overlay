# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="FUSE access to various cloud-file-storage services"
HOMEPAGE="https://joe42.github.com/CloudFusion/"
SRC_URI="https://github.com/joe42/${PN}/archive/v.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="google-storage automate-captchas" #sikuli

RDEPEND="${PYTHON_DEPS}
		google-storage? (
			dev-libs/openssl:0
			virtual/libffi
		)
		automate-captchas? (
			dev-python/pycurl[${PYTHON_USEDEP}]
			dev-libs/libxml2[python,${PYTHON_USEDEP}]
			dev-python/pillow[${PYTHON_USEDEP}]
			app-text/tesseract
		)
		sys-fs/fuse:0"
# sikuli? ( media-libs/opencv sys-apps/sikuli )
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-v.${PV}

DOCS=(
	CHANGELOG
	README.rst
	cloudfusion/config/AmazonS3.ini
	cloudfusion/config/Dropbox.ini
	cloudfusion/config/GDrive.ini
	cloudfusion/config/Google.ini
	cloudfusion/config/Sugarsync.ini
	cloudfusion/config/Webdav_box_testing.ini
	cloudfusion/config/Webdav_gmx_testing.ini
	cloudfusion/config/Webdav.ini
	cloudfusion/config/Webdav_tonline_testing.ini
	cloudfusion/config/Webdav_yandex_testing.ini
	cloudfusion/doc/develop.txt
	cloudfusion/doc/index.txt
	cloudfusion/doc/setup.txt
	cloudfusion/doc/user.txt
)
