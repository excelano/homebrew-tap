class Slipql < Formula
  desc "A query language for Slipcase flyleaves: select, from, where over a directory of containers"
  homepage "https://slipcaseformat.org"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.2.0/slipql-aarch64-apple-darwin.tar.xz"
      sha256 "f656ae3988ad7ae5c271087f15b018d82d192a3052e97db7a0da976278560752"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.2.0/slipql-x86_64-apple-darwin.tar.xz"
      sha256 "cfeec5c0622a86493608f034138ac3de07029bfcff15b8be91a03b904e0bb40d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.2.0/slipql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a81c99e792d47c30fe9e117c801418a68b7363948a2c748693f5c05e550f23c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.2.0/slipql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8e3318ba19bb8cddcf8a241f2b8f9385ae5a18513b92316067bcbe3f7e0b7882"
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
