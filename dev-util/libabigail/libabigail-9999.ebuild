# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Generate using https://github.com/thesamesam/sam-gentoo-scripts/blob/main/niche/generate-libabigail-docs
# Set to 1 if prebuilt, 0 if not
# (the construct below is to allow overriding from env for script)
: ${LIBABIGAIL_DOCS_PREBUILT:=1}

LIBABIGAIL_DOCS_PREBUILT_DEV=sam
LIBABIGAIL_DOCS_VERSION="${PV}"
# Default to generating docs (inc. man pages) if no prebuilt; overridden later
# bug #830088
LIBABIGAIL_DOCS_USEFLAG="+doc"

PYTHON_COMPAT=( python3_{11..14} )

inherit libtool bash-completion-r1 python-any-r1 out-of-source

DESCRIPTION="Suite of tools for checking ABI differences between ELF objects"
HOMEPAGE="https://sourceware.org/libabigail/"
if [[ ${PV} == 9999 ]] ; then
	LIBABIGAIL_DOCS_PREBUILT=0
	EGIT_REPO_URI="https://sourceware.org/git/libabigail.git"
	EGIT_SUBMODULES=()
	inherit autotools git-r3
else
	SRC_URI="https://mirrors.kernel.org/sourceware/libabigail/${P}.tar.xz"
	if [[ ${LIBABIGAIL_DOCS_PREBUILT} == 1 ]] ; then
		SRC_URI+=" !doc? ( https://dev.gentoo.org/~${LIBABIGAIL_DOCS_PREBUILT_DEV}/distfiles/${CATEGORY}/${PN}/${PN}-${LIBABIGAIL_DOCS_VERSION}-docs.tar.xz )"
		LIBABIGAIL_DOCS_USEFLAG="doc"
	fi

	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"
fi

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="0/7"
IUSE="btf debug ${LIBABIGAIL_DOCS_USEFLAG} test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/xz-utils
	dev-libs/elfutils[lzma]
	dev-libs/libxml2:2=
	dev-libs/xxhash
	btf? ( dev-libs/libbpf:= )
	elibc_musl? ( sys-libs/fts-standalone )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	doc? (
		app-text/doxygen[dot]
		dev-python/sphinx
		sys-apps/texinfo
	)
	test? ( ${PYTHON_DEPS} )
"

src_prepare() {
	default
	if [[ ${PV} = 9999 ]] ; then
		eautoreconf
	else
		elibtoolize
	fi
}

my_src_configure() {
	local myeconfargs=(
		--disable-abidb
		--disable-deb
		--disable-fedabipkgdiff
		--disable-rpm
		--disable-rpm415
		--disable-ctf
		# Don't try to run Valgrind on tests.
		--disable-valgrind
		--enable-bash-completion
		--enable-python3
		$(use_enable debug assert)
		$(use_enable btf)
		$(use_enable doc apidoc)
		$(use_enable doc manual)
	)

	econf "${myeconfargs[@]}"
}

my_src_compile() {
	default
	use doc && emake doc
}

my_src_install() {
	emake DESTDIR="${D}" install

	# If USE=doc, there'll be newly generated docs which we install instead.
	if ! use doc && [[ ${LIBABIGAIL_DOCS_PREBUILT} == 1 ]] ; then
		doinfo "${WORKDIR}"/${PN}-${LIBABIGAIL_DOCS_VERSION}-docs/texinfo/*.info
		doman "${WORKDIR}"/${PN}-${LIBABIGAIL_DOCS_VERSION}-docs/man/*.[0-8]
	elif use doc; then
		doman doc/manuals/man/*
		doinfo doc/manuals/texinfo/abigail.info

		dodoc -r doc/manuals/html

		docinto html/api
		dodoc -r doc/api/html/.
	fi
}

my_src_install_all() {
	einstalldocs

	local file
	for file in abicompat abidiff abidw abilint abinilint abipkgdiff abisym fedabipkgdiff ; do
		dobashcomp bash-completion/${file}
	done

	# No static archives
	find "${ED}" -name '*.la' -delete || die
}
