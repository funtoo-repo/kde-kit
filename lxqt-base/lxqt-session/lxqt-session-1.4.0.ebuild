# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="LXQt Session Manager"
HOMEPAGE="https://lxqt.github.io/"

SRC_URI="https://github.com/lxqt/lxqt-session/releases/download/1.4.0/lxqt-session-1.4.0.tar.xz -> lxqt-session-1.4.0.tar.xz"
KEYWORDS="*"

IUSE="+udev"

LICENSE="LGPL-2.1 LGPL-2.1+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:5
	dev-util/lxqt-build-tools
"
DEPEND="
	>=app-misc/qtxdg-tools-3.12.0
	>=dev-libs/libqtxdg-3.12.0
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/kwindowsystem:5[X]
	=lxqt-base/liblxqt-1.4*
	x11-libs/libX11
	x11-misc/xdg-user-dirs
	udev? ( virtual/libudev )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_LIBUDEV=$(usex udev)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	doman lxqt-config-session/man/*.1 lxqt-session/man/*.1

	newenvd - 91lxqt-config-dir <<- _EOF_
		XDG_CONFIG_DIRS='${EPREFIX}/usr/share'
	_EOF_
}

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}