class Slipcase < Formula
  desc "Pack, unpack, repack, inspect, and validate slipcase containers: a ZIP holding a payload file and the TOML metadata that describes it"
  homepage "https://github.com/excelano/slipcase"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.2/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "371412355a556c45852e977de95c3b905644047d0b774d17fe04ab21e33d4766"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.2/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "7dbc6c1d0663ed3bccf9ed7f24f37287f2e1a77d6e19e2e64dfea4a5e143db8f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.2/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "07b53f04c64d2849f8b244e4cf85b2f5b90d459cb40e249d8aee6b1c1532af19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.2/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "97151fc2504e8322bcb39b671ff4efbdec1cd1f8b0d0f40eae81e629023d472c"
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
      bin.install "slipcase"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "slipcase"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "slipcase"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "slipcase"
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
