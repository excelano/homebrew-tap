class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.5.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.5/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "6efa1df57c173b8c3e5a8bc552d75dd7a8085bac9b1efd66624e728397267664"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.5/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "4e1ef5227aa0cf6f96fa2c5bd402bf7b61ad229db226088b8f89e4f2cb20d113"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.5/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4fa005326cc999c3c32902de734c8b5eb4b7a510e5ab910ceec1586ad59829c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.5/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "55f7216412cd624e5d69f83680841128eb23599071acbd9cfb95538a7c0c9099"
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
      bin.install "xshape"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xshape"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xshape"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xshape"
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
