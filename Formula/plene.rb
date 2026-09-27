class Plene < Formula
  desc "Shows Rust source alongside an expanded transcription: the same code with abbreviations and symbols written out in words"
  homepage "https://excelano.com/plene/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/plene/releases/download/v0.2.0/plene-aarch64-apple-darwin.tar.xz"
      sha256 "bc9090243f14aa909244f7bde7ac2322a4c06563f0897324c2c40bdf975736f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/plene/releases/download/v0.2.0/plene-x86_64-apple-darwin.tar.xz"
      sha256 "67565889a5d346b0aa5c43f703bea2725b84a88fc1dec4833f85ffa3d7696c1f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/plene/releases/download/v0.2.0/plene-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c309b2069203bce46bd63bd90a24b9dcc1bb3987ae09b9e8617ffaf27104f586"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/plene/releases/download/v0.2.0/plene-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7392234853699c056fbd3ebacc61d1370c6920b02bf0f2bf980ec36687071676"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "plene"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "plene"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "plene"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "plene"
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
