class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.4.2/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "7beacf7f14236cd61fc8b823c2fa2a3102548bac888ef80f1c1684767e6b6f62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.4.2/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "e4c33ce35e70a41081a39bd03bb3a3c367afd14f0d1b2ba4cdfacb91a80b4855"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.4.2/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a3f42a30b7932860adf901a4f1c1d9f6b250d79e5944925a54fbc1868a3f7b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.4.2/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b9d5988ccd930c4903317e191bdebb2493371a997558edc87cf88dcee8af6ed"
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
      bin.install "xray"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xray"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xray"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xray"
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
