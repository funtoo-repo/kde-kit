# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Merge this to pull in all KDE Plasma and Applications packages"
HOMEPAGE="https://kde.org/"

LICENSE="metapackage"
SLOT="5"
KEYWORDS="*"
IUSE=""

RDEPEND="
	>=kde-apps/kde-apps-meta-${PV}:${SLOT}
	kde-plasma/plasma-meta:5
"
