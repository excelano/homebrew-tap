class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.2.1/xled-aarch64-apple-darwin.tar.xz"
      sha256 "7dbbcd7593367fd6465bc94371fd292ae30f27b9647d4a194bfd1338e28dc107"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.2.1/xled-x86_64-apple-darwin.tar.xz"
      sha256 "aaf9a365a67a8c0ca2624f34593d61f7f1ddd932d5bc8b10824ce478a06a2a14"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.2.1/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aae0b42952cb233da549b1be25ae389bdbeeeca4365e3430cc559559893cba3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.2.1/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4ac9822fb4b0c7b8b7897f9ac272130eb16636b9656fd1fac22e56770e73aac2"
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
