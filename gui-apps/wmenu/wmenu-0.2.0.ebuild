# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="dynamic menu for wlroots compositors, maintains the look and feel of dmenu"
HOMEPAGE="https://codeberg.org/adnano/wmenu/"

if [[ "${PV}" == *9999* ]]; then
	EGIT_REPO_URI="https://codeberg.org/adnano/wmenu.git"
	inherit git-r3
else
	SRC_URI="https://codeberg.org/adnano/wmenu/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv ~x86"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND="
	app-text/scdoc
	dev-util/wayland-scanner
"
RDEPEND="
	x11-libs/cairo
	x11-libs/pango
	dev-libs/wayland
	x11-libs/libxkbcommon
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"
