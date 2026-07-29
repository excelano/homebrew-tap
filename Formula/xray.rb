class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.2.0/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "726f5c10b36d87ef68b9dc623372ea9553889e267ee2becdb9b8fc0cd9f85d0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.2.0/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "e25f6fae007f92a296f1e0a3eb9e038218306c7c6dff8e95e64e6d71ddc534b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.2.0/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f8aacd1d55a8a3ae1d843ff4e7873dee6511e1723dfb2eefc3ed6c718e63b41b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.2.0/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6f282a79d6844904a63e224e6da389ebfdb13b89dcf64baa4d766449ce053fd"
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
    bin.install "xray" if OS.mac? && Hardware::CPU.arm?
    bin.install "xray" if OS.mac? && Hardware::CPU.intel?
    bin.install "xray" if OS.linux? && Hardware::CPU.arm?
    bin.install "xray" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
