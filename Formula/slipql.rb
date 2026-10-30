class Slipql < Formula
  desc "A query language for Slipcase flyleaves: select, from, where over a directory of containers"
  homepage "https://slipcaseformat.org"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.3.0/slipql-aarch64-apple-darwin.tar.xz"
      sha256 "0b59bdb90c8c18298366e2ae3b082d40c439f33f644b9a481be3dc75430d377c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.3.0/slipql-x86_64-apple-darwin.tar.xz"
      sha256 "ccc4fbe626b61b8434a7b624d7e0059973df5f73bb2cc840998de9bfb6d0c903"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.3.0/slipql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "89ea1474b9e210633425c0cfe73387db24d99cf616ef34a900cfcbb426785604"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.3.0/slipql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a748150b315b525c55e72a7550ea818dec3daee9f44ec311d76094daa7ae406d"
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
      bin.install "slipql"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "slipql"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "slipql"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "slipql"
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
