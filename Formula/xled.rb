class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.9.0/xled-aarch64-apple-darwin.tar.xz"
      sha256 "121f3dbad711e9796758672a0bd6439c1e5023909b574877933a4ec77fe042d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.9.0/xled-x86_64-apple-darwin.tar.xz"
      sha256 "76f5784b293e37708b4b74cae9f0e126cc1a066a891bffbaff600f7fabef9f6d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.9.0/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b3000e5b916624965514fcf1ef50262055adc70b633dc400276ed26d6dea6851"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.9.0/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "38a0ea337675b0a8a9d2c5e26ac45424d82f5e03b810437217b1582815db439d"
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
