# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
PYTHON_COMPAT=( python3+ )
KFMIN=5.82.0
QTMIN=5.15.2
VIRTUALX_REQUIRED="test"
inherit cmake python-single-r1 xdg-utils

SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"
KEYWORDS="*"

DESCRIPTION="Free digital painting application. Digital Painting, Creative Freedom!"
HOMEPAGE="https://apps.kde.org/krita/ https://krita.org/en/"

LICENSE="GPL-3"
SLOT="5"
IUSE="color-management fftw gif +gsl heif jpegxl +mypaint-brush-engine openexr pdf qtmedia +raw"
#webp"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# bug 630508
RESTRICT="test"

RDEPEND="${PYTHON_DEPS}
	dev-libs/boost:=
	dev-libs/quazip:0=[qt5(+)]
	$(python_gen_cond_dep '
		dev-python/PyQt5[declarative,gui,widgets,${PYTHON_USEDEP}]
		dev-python/sip:=[${PYTHON_USEDEP}]
	')
	>=dev-qt/qtconcurrent-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5=[-gles2-only]
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtprintsupport-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtx11extras-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/kcompletion-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kcrash-${KFMIN}:5
	>=kde-frameworks/kguiaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kitemmodels-${KFMIN}:5
	>=kde-frameworks/kitemviews-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
	media-gfx/exiv2:=
	media-libs/lcms
	media-libs/libjpeg-turbo:=
	media-libs/libpng:0=
	media-libs/tiff:0
	sys-libs/zlib
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXi
	color-management? ( >=media-libs/opencolorio-2.0.0 )
	fftw? ( sci-libs/fftw:3.0= )
	gif? ( media-libs/giflib )
	gsl? ( sci-libs/gsl:= )
	jpegxl? ( >=media-libs/libjxl-0.7.0_pre20220329 )
	heif? ( >=media-libs/libheif-1.11:= )
	mypaint-brush-engine? ( media-libs/libmypaint:= )
	openexr? ( media-libs/openexr:= )
	pdf? ( app-text/poppler[qt5] )
	qtmedia? ( >=dev-qt/qtmultimedia-${QTMIN}:5 )
	raw? ( media-libs/libraw:= )
"
#	webp? ( >=media-libs/libwebp-1.2.0:= )

DEPEND="${RDEPEND}"
BDEPEND="
	dev-cpp/eigen:3
	dev-lang/perl
	sys-devel/gettext
"

PATCHES=(
	"${FILESDIR}"/${PN}-4.3.1-tests-optional.patch
	"${FILESDIR}"/${P}-add_missing_header_qbuffer.patch
)

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	# Prevent sandbox violation from FindPyQt5.py module
	# See Gentoo-bug 655918
	addpredict /dev/dri

	local mycmakeargs=(
		-DENABLE_UPDATERS=OFF
		-DFETCH_TRANSLATIONS=OFF
		-DKRITA_ENABLE_PCH=OFF # big mess.
		-DCMAKE_DISABLE_FIND_PACKAGE_KSeExpr=ON # not packaged
		-DCMAKE_DISABLE_FIND_PACKAGE_xsimd=ON # not packaged
		-DCMAKE_DISABLE_FIND_WebP=ON # Please enable back when media-libs/libwebp-1.2.0 is available.
		$(cmake_use_find_package color-management OpenColorIO)
		$(cmake_use_find_package fftw FFTW3)
		$(cmake_use_find_package gif GIF)
		$(cmake_use_find_package gsl GSL)
		$(cmake_use_find_package heif HEIF)
		$(cmake_use_find_package jpegxl JPEGXL)
		$(cmake_use_find_package mypaint-brush-engine LibMyPaint)
		$(cmake_use_find_package openexr OpenEXR)
		$(cmake_use_find_package pdf Poppler)
		$(cmake_use_find_package qtmedia Qt5Multimedia)
		$(cmake_use_find_package raw LibRaw)
	)
# WebP support can only be enabled after media-libs/libwebp 
# is upgraded to >=1.2.0.
#
#		$(cmake_use_find_package webp WebP)

	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
