class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.13.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "a19375bab8575c3b83b8ded1afb3ff6fb0b0d39e2ffc6f9fe0e86f0702ac4977"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.13.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "65e5b20184d36e8b6832017c8e07f705c1325fe76e99878df4c99f2b647a070b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.13.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d434118304b332912cedc66246ac3115d6ee425a9d7896503eb0a9d0e01edfe9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.13.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a8ad978f8afe8bbecf3dd9739be847fc2dcd07ce302f68977b39c38762e161c4"
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
      bin.install "xled"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xled"
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
