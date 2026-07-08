class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.3.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "bb02c26d323071ee74874c4eaef0d38edd77885949886edd9a405a5d3366988a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.3.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "f5df17673b0cda11b792441cd870f87431bdc8f4fedf98b1766b5df58243b98e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.3.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8d4540c37966fae44b5d9e7b94adde843203ecb7bc8403ed7fddb837fb9ae92c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.3.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "67e0a778ad41fde0d26888221243d78bb85a60caf7c047dfa3c6a507c96997a6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "xled" if OS.mac? && Hardware::CPU.arm?
    bin.install "xled" if OS.mac? && Hardware::CPU.intel?
    bin.install "xled" if OS.linux? && Hardware::CPU.arm?
    bin.install "xled" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
