class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "3.7.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.7.3/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "118f175539c7f3390f4125c844395b86b1429190e50cdfb8fac33e2494c55d37"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.7.3/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "886eb2de747ae0a3681e1a5e7d087ff770ba7e58a92d2d0daa263d3fd043c19f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.7.3/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef5f83a1133a402fd8b902518b21fa7b64febdac7b55e7bded7452f27920325e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.7.3/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "951e0a4a79a7bb55e79bf15074ed8bc0b69f21c77c549224b5ca20c6148e1ce5"
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
    bin.install "paxc", "paxr" if OS.mac? && Hardware::CPU.arm?
    bin.install "paxc", "paxr" if OS.mac? && Hardware::CPU.intel?
    bin.install "paxc", "paxr" if OS.linux? && Hardware::CPU.arm?
    bin.install "paxc", "paxr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
