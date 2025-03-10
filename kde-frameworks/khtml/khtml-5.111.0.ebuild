# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
QT_MINIMAL=5.15.2
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KHTML web rendering engine"
LICENSE="LGPL-2"
KEYWORDS="*"
IUSE="libressl X"

BDEPEND="
	dev-lang/perl
	dev-util/gperf
"
RDEPEND="
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork ssl)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kjs)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	media-libs/giflib:=
	media-libs/libpng:0=
	>=media-libs/phonon-4.11.0[qt5(+)]
	sys-libs/zlib
	virtual/jpeg:0
	!libressl? ( dev-libs/openssl:0 )
	libressl? ( dev-libs/libressl )
	X? (
		$(add_qt_dep qtx11extras)
		x11-libs/libX11
	)
"
DEPEND="${RDEPEND}
	test? ( $(add_qt_dep qtx11extras) )
	X? ( x11-base/xorg-proto )
"

src_configure() {
	local mycmakeargs=(
		-DWITH_X11=$(usex X)
	)

	kde5_src_configure
}
