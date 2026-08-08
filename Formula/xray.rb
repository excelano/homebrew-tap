class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.3.0/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "b1f6da1c048eb85ba71737acc8c3d2a17043ad56d5d93656039ac2c080a36938"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.3.0/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "313252d05e8067c5575cf837222e698a65e73ec225a3ef60e30a092b6b2718d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.3.0/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1b49884df1db34633a79c03b2ca17685012377b6e7b950f46d61a8090354743c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.3.0/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "83137b754325d6fb442bb308fddee9d4572222de35303c47098429de27056761"
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
