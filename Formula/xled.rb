class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.12.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "0f6b2ad72f97070993e6a6f5559f3b35a720ed4a1598be3aa519e1f38058794d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.12.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "99a5233f595b7053d10078a106a10513620b83a72ef9370f6040558f051d43e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.12.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4315efdf83aac12464373ea18e7d7248cf764fea78ba32748e531b78e383aed2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.12.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "25833e5e6a8a566a34aca98ff9f433f81cfee869fda03e9ef9d4ae1440d22a2c"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "xled"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xled"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
