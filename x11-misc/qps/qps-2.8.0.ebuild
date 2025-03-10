# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Qt GUI Process Manager"
HOMEPAGE="https://lxqt.github.io/"
SRC_URI="https://github.com/lxqt/qps/releases/download/2.8.0/qps-2.8.0.tar.xz -> qps-2.8.0.tar.xz"

LICENSE="GPL-2 GPL-2+ LGPL-2.1+ QPL-1.0"
SLOT="0"
KEYWORDS="*"

BDEPEND="
	dev-qt/linguist-tools:5
	dev-util/lxqt-build-tools
"
DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	=lxqt-base/liblxqt-1.4*
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}


post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}