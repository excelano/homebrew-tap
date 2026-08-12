class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.10.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "13e2c8d55bda35f0aaf2b04dd979bef1fb198196c5c37199c0a0e87e96f399f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.10.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "7907907cc314317b25b4555e89cd7d494b31968d0047a35e4eb67f6bb0371ded"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.10.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a11ac5767427c63d001775266c1dd03e9b12965259bee3d610c428fe8f8a410"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.10.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b16cb58dfaaf4a57ace7c9b518ac1b148c92143250dea93030ae432809a4702e"
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
      bin.install "xled"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xled"
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
