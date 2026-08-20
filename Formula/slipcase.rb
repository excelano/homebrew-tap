class Slipcase < Formula
  desc "Pack, unpack, inspect, and validate slipcase containers: a ZIP holding a payload file and the TOML metadata that describes it"
  homepage "https://github.com/excelano/slipcase"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.2.0/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "5dc6609850066960ac4e31f144501b6cb90bbc4a0a989dffc8d5390582856591"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.2.0/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "c439affb99bbf2a0154bd9efc2b1afb9dc0dafd3c3330b4890d9df98df06f963"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.2.0/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "04c36f48a19c35befd32f73001f6b9be311af1c172a32ebae64396b5185313fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.2.0/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "314476db80d137bd4ff11f1bbc8ff856b5de80e55694f52f93be061833f6b898"
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
