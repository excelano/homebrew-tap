class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.0/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "337129485349feb37c1aa29b757057743b2541162d460b65391e8d09f7fed158"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.0/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "3188c98f9406c55ad4944de8cb160bfbcd3eef8ee6392f843619a884c51dd052"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.0/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2060eff45d171b6c407bd86fe0473a4e7ba7a7ed6bc6f6643b85e8117d922b31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.0/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6fd862fde0765ad1b08332f213110dcb1a162edabaa4c1b90fab1f58460ee4fd"
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
