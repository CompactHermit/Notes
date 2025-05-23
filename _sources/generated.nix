# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  tinymist = {
    pname = "tinymist";
    version = "1eb63870fd491c777ade44a5180c29e1724eff09";
    src = fetchFromGitHub {
      owner = "Myriad-Dreamin";
      repo = "tinymist";
      rev = "1eb63870fd491c777ade44a5180c29e1724eff09";
      fetchSubmodules = false;
      sha256 = "sha256-NfoVmoCzx39RJcKlN2oxFv52jv+C64dxQSnlBGbp68A=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./tinymist-1eb63870fd491c777ade44a5180c29e1724eff09/Cargo.lock;
      outputHashes = {
        "typst-0.12.0" = "sha256-E2wSVHqY3SymCwKgbLsASJYaWfrbF8acH15B2STEBF8=";
        "reflexo-0.5.1" = "sha256-ZOg6N70xw3eit5q+dS4639AAPDF6IQMMcp+Vj/JG3RY=";
        "typst-syntax-0.7.0" = "sha256-yrtOmlFAKOqAmhCP7n0HQCOQpU3DWyms5foCdUb9QTg=";
        "typstfmt_lib-0.2.7" = "sha256-LBYsTCjZ+U+lgd7Z3H1sBcWwseoHsuepPd66bWgfvhI=";
      };
    };
    date = "2024-12-20";
  };
  typst-packages = {
    pname = "typst-packages";
    version = "238fed1a5fc995bff02dd3f60b8756cc4caeed02";
    src = fetchFromGitHub {
      owner = "typst";
      repo = "packages";
      rev = "238fed1a5fc995bff02dd3f60b8756cc4caeed02";
      fetchSubmodules = false;
      sha256 = "sha256-DyQGL2z/LJalioOaR20a9fRW04NYg820zFHXXJ/EE78=";
    };
    date = "2024-12-19";
  };
}
