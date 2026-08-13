class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.4.0/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "0c25104f616fc9008d84a6bf3b96feda4e1a6a81cb5696babe6efcb1987739d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.4.0/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "8d3eaf6abfe65e7722e052c5c791ab9b8c6359073408e3242a6b3b099450c613"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.4.0/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a1dc3d2d69d8bae1da9a598d274e84f9c412f40a7c99284a3e3437ba174325f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.4.0/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "841db8aa42f269ea56ee873b5b9c1f47cf32e54123a8fe53916a189790239b3c"
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
      bin.install "xray"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xray"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xray"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xray"
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
