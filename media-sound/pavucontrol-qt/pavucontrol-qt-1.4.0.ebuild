# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Qt GUI Pulseaudio Mixer"
HOMEPAGE="https://lxqt.github.io/"

SRC_URI="https://github.com/lxqt/pavucontrol-qt/releases/download/1.4.0/pavucontrol-qt-1.4.0.tar.xz -> pavucontrol-qt-1.4.0.tar.xz"
KEYWORDS="*"

LICENSE="GPL-2 GPL-2+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:5
	dev-util/lxqt-build-tools
	virtual/pkgconfig
"
DEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	media-sound/pulseaudio[glib]
"
RDEPEND="${DEPEND}"


post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}