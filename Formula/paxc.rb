class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "4.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v4.0.1/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "5b5e291ca779534569bee54b71f09367462fb25ae66aa9dfda341ec833fd1122"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v4.0.1/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "3ce845fbd8406b5e3e176a59626664b2b25ce5c91d112f4c0ca75f7586b41751"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v4.0.1/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c1571607fdc3d5cd08b58e2d00c0fbea3d71ede055c9775ece7c68952d4e4bec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v4.0.1/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa209469cdf4ba4b29155d39fca90e4bfbe7f4d1ca0c71ada9dc380b0d4bc2f1"
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
