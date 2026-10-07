class Slipql < Formula
  desc "A query language for Slipcase flyleaves: select, from, where over a directory of containers"
  homepage "https://slipcaseformat.org"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.2.1/slipql-aarch64-apple-darwin.tar.xz"
      sha256 "5435e58df827597411c1532cce2c2b7dda0fb8b365de957a6e9c04550864e72f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.2.1/slipql-x86_64-apple-darwin.tar.xz"
      sha256 "49e41bb9da791cafaa378f0a330b3075bf0b28d7d0b4780e1f5a83ab7e623d43"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.2.1/slipql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0304da1923e0627b2751f3b8d4e2fc75bb5dcd2204b63beac6f31c4eb9fae9c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.2.1/slipql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a37b27ad76ef81bf3515990c101f4e90093a6bf115fda26ff3748cdc22bfce43"
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
