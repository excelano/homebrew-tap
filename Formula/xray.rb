class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.6.0/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "350fa962cf963cb8aa7afa50c7e33714cee5f4b847eedf016814c59484be558f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.6.0/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "bd35eb2ad39169e7c561addc42c434fd5846690a26a64cd3b6170c1953502df1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.6.0/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7610f6c06cef773721720fcab0d475d6adb459f8beece98574e22832ac6f19d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.6.0/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a52f3541297a68aee1119086d68d91a81c1c8e3b422be5165a581a68a5b4e40b"
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
