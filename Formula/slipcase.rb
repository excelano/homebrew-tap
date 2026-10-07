class Slipcase < Formula
  desc "Pack, unpack, repack, inspect, and validate Slipcase containers: a ZIP holding a content file and the TOML flyleaf that describes it"
  homepage "https://slipcaseformat.org"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.6.0/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "a3ad5afd1e19d584addd7b75c4e040202d794014c6f9aa2cc8ec81e7ffa51935"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.6.0/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "932b786ce228ce506d70ae399b37be073ec8726f4224c42e3cf9cbdbede89d4d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.6.0/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65805d78d091d906d166dcd1f2577b072f9f948ac2b2ff138b64632cd1b92ff7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.6.0/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b87aafbaedca9d8c1ef4d2b1983cf48825609de5c3a9ea8403f786d7ee8133b5"
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
