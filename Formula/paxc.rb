class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "3.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.7.2/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "ce1662858c4fc384f9db20da638e1f3cf3e5197a5084e4c7dba3cbe6828d4122"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.7.2/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "ae96e89fa86de9e99f371837bf76a86053c598e3e5e109ca184a62e36af079dc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.7.2/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "05f0e9ad19beef3b477f9df394f0c2b2eca4e298c2a01fc1fc92292fb94a4bd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.7.2/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4c7de02bea7233953d5d4c9b48872b6e32e96dcfe55aaf05d7d1939fa823d2d6"
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
