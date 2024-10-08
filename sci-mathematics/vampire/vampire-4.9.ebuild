# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic cmake

DESCRIPTION="The Vampire Prover, theorem prover for first-order logic"
HOMEPAGE="https://vprover.github.io/
	https://github.com/vprover/vampire/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vprover/${PN}.git"
	EGIT_SUBMODULES=()
else
	# v4.9casc2024 - "This is the 4.9 version submitted to CASC in 2024."
	SRC_URI="https://github.com/vprover/${PN}/archive/v${PV}casc2024.tar.gz
		-> ${P}-casc2023.tar.gz"
	S="${WORKDIR}/${PN}-${PV}casc2024"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="debug +z3"
# debug mode needs to be enabled for tests
# https://github.com/vprover/vampire/blob/8197e1d2d86a0b276b5fcb6c02d8122f66b7277e/CMakeLists.txt#L38
RESTRICT="!debug? ( test )"

RDEPEND="
	z3? (
		dev-libs/gmp:=
		>=sci-mathematics/z3-4.11.2:=
	)
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	# -Werror=strict-aliasing warnings, bug #863269
	filter-lto
	append-flags -fno-strict-aliasing

	local CMAKE_BUILD_TYPE=$(usex debug Debug Release)

	local -a mycmakeargs=(
		-DZ3_DIR=$(usex z3 "/usr/$(get_libdir)/cmake/z3/" "")
	)
	cmake_src_configure
}

src_install() {
	local bin_name=$(find "${BUILD_DIR}"/bin/ -type f -name "${PN}*")

	exeinto /usr/bin
	doexe "${bin_name}"
	dosym $(basename "${bin_name}") "/usr/bin/${PN}"

	einstalldocs
}
