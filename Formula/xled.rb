class Xled < Formula
  desc "Sed and awk for tabular data over CSV and DSV files"
  homepage "https://excelano.com/xled/"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/xled/releases/download/v0.1.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "d2f08735788c758ddc7598ec584ea3f09ba5ad93a63b296e4da357b8b347df47"
    end
    on_intel do
      url "https://github.com/excelano/xled/releases/download/v0.1.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "1687fcaf0f955c75f536288acc7d82bf2eaedf2d438fe4656a068ef5d5bbcbf5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/xled/releases/download/v0.1.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8b572e9ecf7ee68064b91d1c2deb98791b9f8863c411bf4617c45b8773e2c41d"
    end
    on_intel do
      url "https://github.com/excelano/xled/releases/download/v0.1.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2b2e891ccaf63ea14afcd6cbdaf823cc5929ec14addbc8ec7558e8de89b80393"
    end
  end

  def install
    bin.install "xled"
  end

  test do
    system "#{bin}/xled", "--version"
  end
end
