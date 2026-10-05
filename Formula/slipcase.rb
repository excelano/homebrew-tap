class Slipcase < Formula
  desc "Pack, unpack, repack, inspect, and validate Slipcase containers: a ZIP holding a content file and the TOML flyleaf that describes it"
  homepage "https://slipcaseformat.org"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.5.0/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "c2bb490e5f2e7cdb5dc6d4291393bb40a15d7e5b382431aa11d6767018319055"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.5.0/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "feed47b77c13af4aae65fc4d3ff4693c3477cfbc261abd9af8841d903ae97423"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.5.0/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c8d0cd230b3d71cb4d002e994a21a505907b0a715adaee968593532f460a3530"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.5.0/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e415243715f69d42e1ef60cdabff6fb73a515926c5f72cfc4a3951947c5db2a8"
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
