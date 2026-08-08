class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "3.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.8.1/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "2ca035fea6ad3c67f39f3b9fa33543347740da40c1b785cb11e5346faee8e27c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.8.1/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "5ede906cb07109232fcee593a9ca618d19134b65512bf63b9cda5f3a708af780"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.8.1/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8f9fb813a0ae14506104325bae8966a245a72b3acdb68b2032718c05c202d901"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.8.1/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c194d3f0f9476b2919459320e574e586aa4583d21e8fa0703d09b2f480b583d3"
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
