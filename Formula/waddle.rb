class Waddle < Formula
  desc "Write ODT and DOCX from DocLang and docling JSON"
  homepage "https://github.com/excelano/waddle"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.1.0/waddle-aarch64-apple-darwin.tar.xz"
      sha256 "b8af9aa85a0d089d63e68465c5d477b49345989cc6ce5b8a748e59af93fe9b67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.1.0/waddle-x86_64-apple-darwin.tar.xz"
      sha256 "a8c3f3b8cc26083287b1a165ba91a5b8f772db6411848c61df02512880611524"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.1.0/waddle-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "48304d901e3a96d1666ec24323e6ef5e343e34a001457d55c4ba1305cbbbe838"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.1.0/waddle-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "758ae001deefc64653a721fc634398f65e7ef9b8f2c1aadb2d50ccb4377a7b34"
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
