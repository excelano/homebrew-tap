class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.4.1/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "1e20dfcd0c49ba52f1b539b80d1d6ce84953e7954a2c3be6a6cbe838ac46c86d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.4.1/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "8fdc6a16dd327f3fba83092ae8fffcadec0ea475cfeadc24c46b4169ad528a36"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.4.1/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f4aa98d12f1f342a3854a9e37ffe496368bde8fb85612b935ef923780c36d688"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.4.1/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cade9855dfb44b818f078031a189fd0cb262523a43919b93fe4a2752ddfdd2dc"
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
      bin.install "xray"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xray"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xray"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xray"
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
