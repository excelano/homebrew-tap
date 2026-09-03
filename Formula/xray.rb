class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.5.0/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "bec2769ea1ac2ec1faf8149a624bdbf907aa994eeb2a89c11e22382d2a2bf88a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.5.0/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "15ed686d63d870efcff9ca3564398b68a2eebb372af9e6bff27f085938d4cbca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.5.0/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6652b14fe13b599a7458a57793a76973846a12c81ec3b26ac0838313773c8291"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.5.0/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "feea77af702fcb5d6a6d16941acae6b54321d154e08a196a2b4ccd5f26ba52b8"
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
