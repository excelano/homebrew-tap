class Slipql < Formula
  desc "A query language for Slipcase flyleaves: select, from, where over a directory of containers"
  homepage "https://slipcaseformat.org"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.1.1/slipql-aarch64-apple-darwin.tar.xz"
      sha256 "53729cbb26eb015a7affd5db76d7b745414a75f443fde706cb9c881220712456"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.1.1/slipql-x86_64-apple-darwin.tar.xz"
      sha256 "042280b8f840e099db963e7f20a0fe1ad8a64fef94c024f63f0929d9d9c18340"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.1.1/slipql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d8119aeddd602e5da1fff0c39666c57117369d1de376e9af8ab1fac7e736fd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.1.1/slipql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "519278d55f6eef1f9f4deea4396f683c197c93d97ee74ff474622aa6f5f72dd5"
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
