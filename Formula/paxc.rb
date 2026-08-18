class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "4.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v4.0.0/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "301808c3435d90f0266d44e952f132be2d65a8e26c8edf108906dfb688e330dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v4.0.0/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "aebadcecc0b9a96331091aaecfd33d7b1b84f1c6c5aec73f6ea95d9401c07f2c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v4.0.0/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a8dab2d5d94218aca7829403c75a90e7fb554d8878f3b1f677c17cff7dc1babd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v4.0.0/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1e53c2422febc5b8a5223a959a1b1cd84e29215560c63310e89c74a74e86a5b7"
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
