class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.1.0/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "e637f571cb5ac919733eaaa1d8bf83d33609ca148014805082ae09220ababd6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.1.0/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "c770353c5e7293d7f95ce3e0c05c372652f9933dc19a4c86a8a9d21e8d8d5184"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.1.0/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8dc7309316093dee2ede4ad35425d73f66960c1eadb066e8b4ddbbe3fc7d095b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.1.0/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d354562f4f9a48a0467b5f7cca2902aff6f5d9495e54f87550bddea8048bad17"
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
