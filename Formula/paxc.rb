class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "3.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.8.0/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "7ba7a8993969edd02680f1a99a6f0b9c9c8a046a4f16912edd62695ba6609b2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.8.0/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "571d9382162335179e21a752f439357c1af303e4e654a13c7d877088200b1a34"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.8.0/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a8854f71e038e11205712ca7bd1579c2b68bb0a1b73b7bf5b44e5c723b4d9b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.8.0/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "245e6cdfbb3d095e86c4d1ad34c330c5db9b0f789239846a2994174ff75ba979"
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
