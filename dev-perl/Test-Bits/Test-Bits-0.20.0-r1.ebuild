# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=DROLSKY
DIST_VERSION=0.02
inherit perl-module

DESCRIPTION="Provides a bits_is() subroutine for testing binary data"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 ~loong ~riscv x86"

RDEPEND="
	dev-perl/List-AllUtils
"
BDEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.880.0
	)
"
PERL_RM_FILES=(
	"t/author-pod-spell.t"
	"t/release-cpan-changes.t"
	"t/release-no-tabs.t"
	"t/release-eol.t"
	"t/release-pod-coverage.t"
	"t/release-pod-linkcheck.t"
	"t/release-pod-no404s.t"
	"t/release-pod-syntax.t"
)
