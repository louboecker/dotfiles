{ stdenv, fetchzip }: stdenv.mkDerivation {
  pname = "helium";
  version = "0.7.9.1";

  src = fetchzip {
    url = "https://github.com/imputnet/helium-linux/releases/download/0.7.9.1/helium-0.7.9.1-x86_64_linux.tar.xz";
    sha256 = "";
  };
}