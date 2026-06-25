class Ved < Formula
  desc "The verbose ed — a drop-in compatible ed clone with friendly errors and a built-in help system"
  homepage "https://excelano.com/ved/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/ved/releases/download/v0.2.0/ved-aarch64-apple-darwin.tar.xz"
      sha256 "2e45f554fa544e411780b03f8cb598d49e1a7d88df0d6c1e725f60b95bd83e6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/ved/releases/download/v0.2.0/ved-x86_64-apple-darwin.tar.xz"
      sha256 "9286dac7105498a7b7f2a4aa9a271a8c6b1ad531d933e1c46a4b0ef69047e295"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/ved/releases/download/v0.2.0/ved-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "43882f798aedde04a143eecadda8afa93754b28798c9e93e8e2681e2a56f6b32"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/ved/releases/download/v0.2.0/ved-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d7dc6805c66498d0338a9bebed4d5e4e5c565006554463a17101a1961891dd7"
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
    bin.install "ved" if OS.mac? && Hardware::CPU.arm?
    bin.install "ved" if OS.mac? && Hardware::CPU.intel?
    bin.install "ved" if OS.linux? && Hardware::CPU.arm?
    bin.install "ved" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
