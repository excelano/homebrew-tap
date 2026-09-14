class Waddle < Formula
  desc "Write ODT and DOCX from DocLang and docling JSON"
  homepage "https://github.com/excelano/waddle"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.1.3/waddle-aarch64-apple-darwin.tar.xz"
      sha256 "71f7c0974433d2c8531181d939ce87809fbe232a0d65095e45c4fc2851d1b5b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.1.3/waddle-x86_64-apple-darwin.tar.xz"
      sha256 "28d2ce92eb5906869d20d535732cfe43648ef381ae938d6faf3e7067cd759d2d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.1.3/waddle-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6c9a54faa0da3a0e22d0cb262909454cb8af3ed9bbb6e40aba1fb9f32d59699a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.1.3/waddle-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed46599f844e750821f85d363fcce46f2dd2fc2e219733f4a86e614b8fe0f1cb"
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
