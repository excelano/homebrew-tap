class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.11.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "a40551578ced9592d066263288c03530f45bd11d0d22206f8a7d744dc03e4077"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.11.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "475f6127d55204cf6be902e615a0cda89aa28f6d93a3a8c30882c572eb4299bd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.11.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e53e1598be65275ef3a644c40396bc4fd1009272221923027353adf50a53cbb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.11.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e9c558c36bf17426c3a98dc7dab3d3ee328d039402bc30149894da9a9aa8033"
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
