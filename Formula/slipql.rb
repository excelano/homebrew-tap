class Slipql < Formula
  desc "A query language for Slipcase metadata: select, from, where over a directory of containers"
  homepage "https://slipcaseformat.org"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.1.0/slipql-aarch64-apple-darwin.tar.xz"
      sha256 "ccb8c116dd472181d5ac65116a784453a98c06c28c4cd0000500c43311b1ee3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.1.0/slipql-x86_64-apple-darwin.tar.xz"
      sha256 "c5db9c89b7af3fe37cc2637f364ba7dabe6926fa5110b16f7bbb08430d5740db"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/slipql/releases/download/v0.1.0/slipql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "16ec617735856458f4a5b0b08047b2b5a5e31587015b02e351b586c18404a3e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/slipql/releases/download/v0.1.0/slipql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7a4ab5b343ccf31714d98f09f6991ab23a2d083e489dbcd7d88175696f9c2f76"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "slipql"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "slipql"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "slipql"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "slipql"
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
