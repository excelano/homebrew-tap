class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.4.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "2cc9998f25b0ab93097b875856cec9ea07197dc9b110d365dd7b36f36b684844"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.4.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "9b91652a28c93d32a94ff84ef378044f97a5c12c80242a67e2a324952e8a9b2d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.4.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f5364d7f6dc56d80b6c67f0cf4924b3f19b99ce456a00262fdcfcfa26c844776"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.4.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "81765924682594685837869e3e1aaee01b9e86c417a243ada9a2450d1bfde500"
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
