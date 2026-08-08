class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.3.0/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "d40697a8665f4ddbe7f9fc35d940ab87564626ca473056d09279bbee599bae5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.3.0/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "0aab6a9af754081599acb34ea3a931302054100c7a317a13ab96162561ffd835"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.3.0/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d3ad4d726361014ac99df1fe0f715cb7035c269c8a4071d3d62017419371a88"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.3.0/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d91037c7218f3a9712c05d44b61808d58cf99008c08a4dc196ea058e3b21a40"
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
