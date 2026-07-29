class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.5.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "23a5a9ada3d4c91bcab5db3157df11e5940a84bdf3498aca6acaa520d59f4f12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.5.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "efd7fd6d68221291fdbf4d146f59b8718ae84df9c46ad3e959abaefe06e6a354"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.5.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a64aae8a80be4be2a83c3c592c35b521c99accf310e40c11b26e2da1fea156ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.5.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e9a3c35fd76b9fbf0b8e9f82538e66f11bfbeb22c8bd547f48fba2ee2c776889"
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
