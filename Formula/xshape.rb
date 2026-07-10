class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.1.0/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "a02b267e6b8bc249a170734347f4a24b857bbda72d5c29e544d051b9e4221918"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.1.0/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "0bf97460db3cbeb80e8e79086f2be16b656f5f0d61170f8c2b4c6055cf68c00c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.1.0/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f520c5bb017457c7af577794aa1e5938229a4167f2fb39f45ef98f9c81d5aabc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.1.0/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fe6b4f209fc15e675ef9a05c3b87849310562ba5d4a74cabc08355fff1c90ddf"
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
