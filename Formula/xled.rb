class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.12.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.12.1/xled-aarch64-apple-darwin.tar.xz"
      sha256 "eb129be143945f50b8cd5e649e61db56e59bf9e90052becaad931a6c04f96654"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.12.1/xled-x86_64-apple-darwin.tar.xz"
      sha256 "c057d7c157efa1be55f1455ae05d7282d269b7bac4905d0823abbfd57626ffcc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.12.1/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8ed75a1d0eb4474c33c1e0f502087fcc870d05c39ac83f42801dba0559ca7fb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.12.1/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4611cfd654d09c16686560f7caecaa762adeb6076036b2d251fb32ae9e329d9a"
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
