class Slipcase < Formula
  desc "Pack, unpack, repack, inspect, and validate slipcase containers: a ZIP holding a payload file and the TOML metadata that describes it"
  homepage "https://github.com/excelano/slipcase"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.0/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "459555fc82a7c62c8ed5eb74ba843a4827063ce96c546274d09962c68dcb3e58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.0/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "7ab596e2708a9a759e8d7f2e5e33257e2d12359d20ab87745ad247e44f0a8102"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.0/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f14591b3765435380776de882f56949f9ca7d9f6ed2489b78c2919146084a555"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.0/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c37e63581d9f7169cc27b0859f4167ff180492889635273f6c44ce24bed3a110"
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
