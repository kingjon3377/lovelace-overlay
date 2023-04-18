# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="98"

T2_PATCHES_VER=13-1
EXTRAVERSION="-${PN}/-*"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Kernel sources including patches for T2 Mac hardware"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches https://t2linux.org https://wiki.t2linux.org/guides/kernel/"
SRC_URI="https://github.com/t2linux/kernel/archive/refs/tags/t2-v${PV}.tar.gz -> linux-${KV_FULL}.tar.gz
	${GENPATCHES_URI} ${ARCH_URI}"

KEYWORDS="~amd64"

# Adapted from sys-kernel/raspberrypi-sources
universal_unpack() {
	unpack linux-${KV_FULL}.tar.gz

	# We want to rename the unpacked directory to a nice normalised string
	# bug #762766
	mv "${WORKDIR}"/kernel-t2-v${PV} "${WORKDIR}"/linux-${KV_FULL} || die

	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2>/dev/null

	cd "${S}" || die "cd '${S}' failed"
}

UNIPATCH_EXCLUDE="1000_linux-5.15.1.patch
	1001_linux-5.15.2.patch
	1002_linux-5.15.3.patch
	1003_linux-5.15.4.patch
	1004_linux-5.15.5.patch
	1005_linux-5.15.6.patch
	1006_linux-5.15.7.patch
	1007_linux-5.15.8.patch
	1008_linux-5.15.9.patch
	1009_linux-5.15.10.patch
	1010_linux-5.15.11.patch
	1011_linux-5.15.12.patch
	1012_linux-5.15.13.patch
	1013_linux-5.15.14.patch
	1014_linux-5.15.15.patch
	1015_linux-5.15.16.patch
	1016_linux-5.15.17.patch
	1017_linux-5.15.18.patch
	1018_linux-5.15.19.patch
	1019_linux-5.15.20.patch
	1020_linux-5.15.21.patch
	1021_linux-5.15.22.patch
	1022_linux-5.15.23.patch
	1023_linux-5.15.24.patch
	1024_linux-5.15.25.patch
	1025_linux-5.15.26.patch
	1026_linux-5.15.27.patch
	1027_linux-5.15.28.patch
	1028_linux-5.15.29.patch
	1029_linux-5.15.30.patch
	1030_linux-5.15.31.patch
	1031_linux-5.15.32.patch
	1032_linux-5.15.33.patch
	1033_linux-5.15.34.patch
	1034_linux-5.15.35.patch
	1035_linux-5.15.36.patch
	1036_linux-5.15.37.patch
	1037_linux-5.15.38.patch
	1038_linux-5.15.39.patch
	1039_linux-5.15.40.patch
	1040_linux-5.15.41.patch
	1041_linux-5.15.42.patch
	1042_linux-5.15.43.patch
	1043_linux-5.15.44.patch
	1044_linux-5.15.45.patch
	1045_linux-5.15.46.patch
	1046_linux-5.15.47.patch
	1047_linux-5.15.48.patch
	1048_linux-5.15.49.patch
	1049_linux-5.15.50.patch
	1050_linux-5.15.51.patch
	1051_linux-5.15.52.patch
	1052_linux-5.15.53.patch
	1053_linux-5.15.54.patch
	1054_linux-5.15.55.patch
	1055_linux-5.15.56.patch
	1056_linux-5.15.57.patch
	1057_linux-5.15.58.patch
	1058_linux-5.15.59.patch
	1059_linux-5.15.60.patch
	1060_linux-5.15.61.patch
	1061_linux-5.15.62.patch
	1062_linux-5.15.63.patch
	1063_linux-5.15.64.patch
	1064_linux-5.15.65.patch
	1065_linux-5.15.66.patch
	1066_linux-5.15.67.patch
	1067_linux-5.15.68.patch
	1068_linux-5.15.69.patch
	1069_linux-5.15.70.patch
	1070_linux-5.15.71.patch
	1071_linux-5.15.72.patch
	1072_linux-5.15.73.patch
	1073_linux-5.15.74.patch
	1074_linux-5.15.75.patch
	1075_linux-5.15.76.patch
	1076_linux-5.15.77.patch
	1077_linux-5.15.78.patch
	1078_linux-5.15.79.patch
	1079_linux-5.15.80.patch
	1080_linux-5.15.81.patch
	1081_linux-5.15.82.patch
	1082_linux-5.15.83.patch
	1083_linux-5.15.84.patch
	1084_linux-5.15.85.patch
	1085_linux-5.15.86.patch
	1086_linux-5.15.87.patch
	1087_linux-5.15.88.patch
	1088_linux-5.15.89.patch
	1089_linux-5.15.90.patch
	1090_linux-5.15.91.patch
	1091_linux-5.15.92.patch
	1092_linux-5.15.93.patch
	1093_linux-5.15.94.patch
	"

# TODO: Just use T2 pre-patched source repository instead of $KERNEL_URI
# TODO: Include such of these excluded patches as make sense in the module ebuilds
# TODO: Some of these excluded patches include pieces that may make sense, but
# others that don't apply cleanly. Investigate and include the cleanly-applying
# parts in FILESDIR.
# t2linux wiki generic instructions say to exclude 1001*
#UNIPATCH_EXCLUDE="1001-Put-apple-bce-and-apple-ibridge-in-drivers-staging.patch
	#1002-add-modalias-to-apple-bce.patch
	#8001-brcmfmac-pcie-Declare-missing-firmware-files-in-pcie.patch
	#8002-brcmfmac-firmware-Support-having-multiple-alt-paths.patch
	#8003-brcmfmac-firmware-Handle-per-board-clm_blob-files.patch
	#8005-brcmfmac-firmware-Support-passing-in-multiple-board_.patch
	#8008-brcmfmac-pcie-Perform-firmware-selection-for-Apple-p.patch"

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn ""

	kernel-2_pkg_setup
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on these patchsets, see:"
	einfo "${HOMEPAGE}"
	einfo
	einfo "Run the firmware.sh script supplied by t2linux.org in MacOS and then Linux"
	einfo "to get firmware for WiFi and Bluetooth."
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
