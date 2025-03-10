# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT_MINIMAL=5.15.1
inherit kde5

DESCRIPTION="Framework for network service discovery using Zeroconf"
LICENSE="LGPL-2+"
KEYWORDS="*"
IUSE="nls zeroconf"

BDEPEND="
	nls? ( $(add_qt_dep linguist-tools) )
"
DEPEND="
	$(add_qt_dep qtnetwork)
	zeroconf? (
		$(add_qt_dep qtdbus)
		net-dns/avahi[mdnsresponder-compat]
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_DNSSD=ON
		$(cmake-utils_use_find_package zeroconf Avahi)
	)

	kde5_src_configure
}