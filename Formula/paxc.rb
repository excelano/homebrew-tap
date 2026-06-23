class Paxc < Formula
  desc "Compiler for the pax DSL, producing Power Automate cloud flows"
  homepage "https://excelano.com/paxc/"
  version "3.7.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/paxc/releases/download/v3.7.1/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "7f37bf649be24cbd8669cf1625554e9cbb3490d042fd0a0a0960f0f1a0b5099f"
    end
    on_intel do
      url "https://github.com/excelano/paxc/releases/download/v3.7.1/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "62d91b03de986219ba45ead78861d9ee3e8ef6d8b0821cdb7a8b1550ecebd1e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/paxc/releases/download/v3.7.1/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e2c79a824d7e56b7461a0a44dcd0a246809110efdb84908f297f3fe19ecc08eb"
    end
    on_intel do
      url "https://github.com/excelano/paxc/releases/download/v3.7.1/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9c96daa7429d43441da5b35408d0156fbac83aa11906ed1cd92a9ee309f4fafc"
    end
  end

  def install
    bin.install "paxc", "paxr"
  end

  test do
    system "#{bin}/paxc", "--version"
  end
end
