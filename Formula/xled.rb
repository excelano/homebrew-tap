class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.8.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "579c7e85a291f882e524d0a51e0aac0aa4a4427b3dcf41edc3eddfa2084a5c52"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.8.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "336f79a184086a7fb0c1ac8495a3391d9e74a9f885aa29e5ed823a41f1f8747e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.8.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4a621e62ea67339a17921fa3c7b51163f50d2eb9cc0815a9a883d83b43fec986"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.8.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e98ceda9be5216f38416a185424a721fcba3e416871e65329906cb60d4dc98f8"
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
