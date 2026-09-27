class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.5.1/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "ef97b2a54cc2adf86910d5374551e27abbc3e9e0b29357f50acb462a7f9a41a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.5.1/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "4b094999fcba1796c5298324be8e859a8aee371e330ad6abb0b997c77b7847ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.5.1/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6cf618ed4e98e8b76d69e932d7047d57bae28426a9b36df394b0bb8a690a3992"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.5.1/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b90abd2537fcca25da3742a63324983e976a17e8e86728fd996c932120bf6625"
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
