class Ved < Formula
  desc "The verbose ed — an ed clone with friendly errors and a built-in help system"
  homepage "https://excelano.com/ved/"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/ved/releases/download/v0.2.1/ved-aarch64-apple-darwin.tar.xz"
      sha256 "4297e83fd811e228e64ab85e2f0c564d369408dd63fc56c30ba8cee5c9277a64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/ved/releases/download/v0.2.1/ved-x86_64-apple-darwin.tar.xz"
      sha256 "3d1d0302a8572771c77eb469a51946d415fcabd05f6bfce50d00fe5a5d8990dc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/ved/releases/download/v0.2.1/ved-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e32a3d7b8de633a003eebd098fde1fe89440eef49c2672b8ca01a3b3bf2a5826"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/ved/releases/download/v0.2.1/ved-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d7cd82392aa16866ce343ef97267ad9988f8cdc6767c5425fbe8313986ffe5fb"
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
      bin.install "ved"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ved"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ved"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ved"
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
