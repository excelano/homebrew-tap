class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.12.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.12.2/xled-aarch64-apple-darwin.tar.xz"
      sha256 "5520340a6acc9b5a0702a5e7f9792dee9fbdeebfb3b3904ec5c5c21f485e0272"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.12.2/xled-x86_64-apple-darwin.tar.xz"
      sha256 "ad9224c09907894210c786fa086ae3bd3af322ae2b7e32a67bcd470ac2cbaf47"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.12.2/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "295bb6be5c0deab149a4ea8a12c25be38053a26aeb555c695ed723047e95d8de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.12.2/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d5d726898de0ce3fde2d4f1bf9b82c27afc60642e7afcc044685acceee5dded2"
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
