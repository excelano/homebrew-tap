class Slipcase < Formula
  desc "Pack, unpack, repack, inspect, and validate Slipcase containers: a ZIP holding a payload file and the TOML metadata that describes it"
  homepage "https://slipcaseformat.org"
  version "0.3.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.11/slipcase-aarch64-apple-darwin.tar.xz"
      sha256 "a3ac31297205f91ef68931ddf697c1ab8b3c4e18bb06bbae3ab5020183e4201f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.11/slipcase-x86_64-apple-darwin.tar.xz"
      sha256 "7e1109add5b174c0d9c2ccc8236309080c8026b2719f13c55da58decc36b86ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.11/slipcase-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c973190f2a9093fdef93d4aa6920942ae8cfe02ea1a34aebab92b3b35b2fa67d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slpc-rust/releases/download/v0.3.11/slipcase-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "63e5cfcaf0e3847ce3eb169680c5d90f23ea14a232d24ac233d0097b5e392197"
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
