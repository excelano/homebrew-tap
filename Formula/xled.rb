class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.7.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "3e767ad6b465906f9cfcee995e7cc69c47726c8db108fe87f7b9d582458b1199"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.7.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "2102b561f2c14abf1cbf4a16dbf3dd8cf7236cc678b16d0502816a89895dc05a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.7.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c3b961156c8f24987f61ed48f06074c3a332d6ba0d7df5f4eb1f752d11dd46f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.7.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "96e9deaa4d791840ac1ff0593a9b7af272170f09c14f88656f5bb90a43d9c6b1"
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
    bin.install "xled" if OS.mac? && Hardware::CPU.arm?
    bin.install "xled" if OS.mac? && Hardware::CPU.intel?
    bin.install "xled" if OS.linux? && Hardware::CPU.arm?
    bin.install "xled" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
