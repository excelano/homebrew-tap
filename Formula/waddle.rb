class Waddle < Formula
  desc "Write ODT and DOCX from DocLang and docling JSON"
  homepage "https://github.com/excelano/waddle"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.2.0/waddle-aarch64-apple-darwin.tar.xz"
      sha256 "e1958b71b69d0aec2a68fae1e1a57b2a70a906d652d345d7c4fa19d513d7d321"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.2.0/waddle-x86_64-apple-darwin.tar.xz"
      sha256 "972b6c9510b80290f53c224cf08951f97e2c6da469a053f1a34f59a1e14e1e28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.2.0/waddle-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f15a42f081f276d0bf9f4e86fa24ceaa307c08d6ac7607774e0dd38d375dd7b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.2.0/waddle-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0f18fd116fac4251e2d1258e081ffb08acb4343dc81c9385f3144baac5269d27"
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
