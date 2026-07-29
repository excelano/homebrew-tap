class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.2.0/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "20459b7ce2cc44fb802889b0c719f3c32de8158ddcaac7ce247999f42daff7b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.2.0/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "8adcf8ab0c9ab1da6f648d7e2d28f48686a85105a3a97235b24058e416ccc4ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.2.0/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2dc9e154a79603102836ac7ba4b49576385280e27be6cb99907d2ffcf721baf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.2.0/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8eff2722004f88f75e9102f788655768e089be45deb81a0cd70e9107f3e80541"
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
    bin.install "xshape" if OS.mac? && Hardware::CPU.arm?
    bin.install "xshape" if OS.mac? && Hardware::CPU.intel?
    bin.install "xshape" if OS.linux? && Hardware::CPU.arm?
    bin.install "xshape" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
