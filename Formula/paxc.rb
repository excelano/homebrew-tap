class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "3.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.9.0/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "a7763bf7cb0028266ec35682b21ac79e7f55c6cc19c82bbc25cc05dfd46e19a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.9.0/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "7551255f545b7aaa5d4a84d7dd5e2a66a1eed4d6520847c1e48c2c2205816f37"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.9.0/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8e33b71768775ee99f66258563d4823e4954a631ea5116f913e57f672474ed04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.9.0/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "96308ee93e49b814de3cf2719cfaf89996103d558053c8897b13f212a5fdd030"
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
