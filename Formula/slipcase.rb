class Slipcase < Formula
  desc "Pack, unpack, inspect, and validate slipcase containers: a ZIP holding a payload file and the TOML metadata that describes it"
  homepage "https://github.com/excelano/slipcase"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.1.1/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "5f3990f244c13b77c7b4905d685f1e46941a72d7a39c14fd644e59b64c63ccf6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.1.1/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "b896dfd03b991263910d0f11a72b36abde37d2d16daf411cdd2f3bfc1a590e13"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.1.1/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8588e02e5322d2ae38f6919fd3a929d11aa36f277e81a836e059d343bb303112"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.1.1/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "333d562141f0507feb2c65a486a30938f336538338cee45866b31fbea12a0c06"
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
