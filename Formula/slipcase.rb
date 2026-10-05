class Slipcase < Formula
  desc "Pack, unpack, repack, inspect, and validate Slipcase containers: a ZIP holding a content file and the TOML flyleaf that describes it"
  homepage "https://slipcaseformat.org"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.4.1/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "43aac1a7ef1f8f17fe77e2d95d14eba49529aebdcade46a9d6911f9b80f394ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.4.1/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "ff044cbb1cc4398952c5b80f0f79f54aa099351433fa9624b8f7244b97787ec2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.4.1/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4863eedfdbc25690d51d529475cba8fb85fbf6cbe234bb29a7d253b37f7dacde"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.4.1/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a035c6572aa47630035cda70a32e8180efaa1e4a4ae1afa87f85d361bbc64c78"
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
