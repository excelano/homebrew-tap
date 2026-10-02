class Plene < Formula
  desc "Shows Rust source alongside an expanded transcription: the same code with abbreviations and symbols written out in words"
  homepage "https://excelano.com/plene/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/plene/releases/download/v0.3.0/plene-aarch64-apple-darwin.tar.xz"
      sha256 "55d0bf69a6597c81d0e837935a4963e9eb2b0f6dcb66af6d56a1ac213be8f0c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/plene/releases/download/v0.3.0/plene-x86_64-apple-darwin.tar.xz"
      sha256 "315bfe9c1bfb6112228752dddab1478ea15612f3fd49b320ed8636639ae618d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/plene/releases/download/v0.3.0/plene-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a51932649b54c4452a14ebe55817d297b5ce47a170c8aa4d3862c3bb282162ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/plene/releases/download/v0.3.0/plene-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "450a61f24d397bc5be1fe3bbfe984c1931ee9880090cd9a93cb01297043dd64a"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "plene"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "plene"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "plene"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "plene"
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
