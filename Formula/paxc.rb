class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "4.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v4.0.2/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "9c283c54baa46cf6a006269811d3d5b166d3802b41c93821eb4255f53f977c69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v4.0.2/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "d8f97ff3abce98b7f6b694e10f4e3214a7fcde872e9ce1fa1cdaf6f6aca05a8b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v4.0.2/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d99a0dd3f38a96f9a64706c392029640f87c5ceb18bf99e6a287a99ec4cdf8c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v4.0.2/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c800ad7c447a0386a2933db270f0c4436353c59912e42843e5ab3da949aca184"
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
      bin.install "paxc", "paxr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "paxc", "paxr"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "paxc", "paxr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "paxc", "paxr"
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
