class Xql < Formula
  desc "Run real SQL against SharePoint Lists and CSV files"
  homepage "https://excelano.com/xql/"
  version "1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/xql/releases/download/v1.3.0/xql_1.3.0_darwin_arm64.tar.gz"
      sha256 "178148175c5d56a130d0628b0aed4ca7b72c2fba6c88ada605ea1b29460c01bb"
    end
    on_intel do
      url "https://github.com/excelano/xql/releases/download/v1.3.0/xql_1.3.0_darwin_amd64.tar.gz"
      sha256 "9048125219e610b58e60bc6529f1eeaa35801a3237ef4c4ad2f6b68499c8e810"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/xql/releases/download/v1.3.0/xql_1.3.0_linux_arm64.tar.gz"
      sha256 "810e9b488bd4e07241a04895ee110d48b1895a867cc649788ea9117b97932579"
    end
    on_intel do
      url "https://github.com/excelano/xql/releases/download/v1.3.0/xql_1.3.0_linux_amd64.tar.gz"
      sha256 "39775af09ab43edca385bd5bf159909b8114ac2aab673bff2b56c4c9f9203e48"
    end
  end

  def install
    bin.install "xql"
  end

  test do
    system "#{bin}/xql", "--version"
  end
end
