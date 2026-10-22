class Waddle < Formula
  desc "Write ODT and DOCX from DocLang and docling JSON"
  homepage "https://github.com/excelano/waddle"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.3.1/waddle-aarch64-apple-darwin.tar.xz"
      sha256 "48fb1d23228d10253c76357292b225a5ab23998b5ce0f1520a2d431e6c4a4946"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.3.1/waddle-x86_64-apple-darwin.tar.xz"
      sha256 "925533a7b85b7897aec9d01eac02d59c54079f2e07ef9819f8cf9d18b4a13a2c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.3.1/waddle-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7a8a08116781794d52cf0ccccc69aa9298fd7eb97f6ae7b0fdf63d721618fd47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.3.1/waddle-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8d51be8d7d3972554bc99e0e9dd8866922c5f7480cd272718868b077c7c9cb0e"
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
      bin.install "waddle"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "waddle"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "waddle"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "waddle"
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
