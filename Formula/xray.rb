class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.6.1/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "47e54640ac6d941711e625084434238a79850fd86c615ad7552929f5e895f1b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.6.1/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "128ee95f770e323ba10d9eee9f33c93ff8987c305e7866946e50f9d8110da81a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.6.1/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f21dcf8dd6dd6082bd0d560831034a27c7e19e95846ae09726b7405f027ac49f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.6.1/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66ef012ef248fad973d248bffdf53268fc57a2fe1c83845cea27e3083d7818d4"
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
