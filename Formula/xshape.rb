class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.4.0/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "4485931ccfe98a44825a19115e091fd24c85bb5b1c26093dc68c696064f14af1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.4.0/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "58fcc5fe3df9b38f590f48f7faebc4c1713854a3d20df20cf78554013087604e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.4.0/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "597610be43424c2747a7b34e148bbd31f4d70ee3c8dcdd0d04d29b8c7db885c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.4.0/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9cacd140659c0185303c417c13e76d89169b789dc63bbb8ab382504511bb2632"
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
