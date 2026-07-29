class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.6.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "20be73809ed5541445ea6ae92c377b9450137a2cd49beba4bc97ba046f4b8aa5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.6.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "e0c0a5c3a566fac30fe445e2b9f7ca9124d4e92166a4e7604ef16856abc357ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.6.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "46380de86f1601002b1f4ebf21fb48753023a9f5c6dc34e205e3efdba1ed226e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.6.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c57f0c746ed782050ad62ba3088c6663378b858987c1a2a5926579dfd789bb2a"
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
    bin.install "xled" if OS.mac? && Hardware::CPU.arm?
    bin.install "xled" if OS.mac? && Hardware::CPU.intel?
    bin.install "xled" if OS.linux? && Hardware::CPU.arm?
    bin.install "xled" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
