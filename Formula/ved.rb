class Ved < Formula
  desc "Verbose ed clone with friendly errors, in pure-stdlib Rust"
  homepage "https://excelano.com/ved/"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/ved/releases/download/v0.1.5/ved-aarch64-apple-darwin.tar.xz"
      sha256 "83333c0f3956f7779913be59918010188bcb869d5dc2e5e721a3c0a917ce2630"
    end
    on_intel do
      url "https://github.com/excelano/ved/releases/download/v0.1.5/ved-x86_64-apple-darwin.tar.xz"
      sha256 "8ce86bd2ec51b8fc90186dd70b77e75f1259923eaac1552cb2b7e3520a57aef4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/ved/releases/download/v0.1.5/ved-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "026f0899e9bc8484ee240e5a370d59a2b500dea17d014e71c2436d0e6b910c88"
    end
    on_intel do
      url "https://github.com/excelano/ved/releases/download/v0.1.5/ved-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0356124ae85a7ae8a0ee38be111b22b99aa78180da5cedeecb837348e4d60ab1"
    end
  end

  def install
    bin.install "ved"
  end

  test do
    system "#{bin}/ved", "--version"
  end
end
