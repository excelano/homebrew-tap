class Slipcase < Formula
  desc "Pack, unpack, repack, inspect, and validate slipcase containers: a ZIP holding a payload file and the TOML metadata that describes it"
  homepage "https://github.com/excelano/slipcase"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.4/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "42ece6a448bb923370f9072b857ffe3b6ca680d78d07d28b5887039781f96e6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.4/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "ce274cba6fc1257c95b72bd1b64370577a93c3a3239ab88af2ea158cc01c33f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.4/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "03a43f3a40c0fd4d6769d8ec8e803837ccc0810cb89d3c8a485ff4ec981213a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.4/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2a64c1cb6bf4b33fae9e8930f227c484596d5332b42d167ad86c9d06f2a82b32"
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
