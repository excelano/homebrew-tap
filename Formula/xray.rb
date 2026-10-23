class Xray < Formula
  desc "a read-only profiler for tabular data — what a CSV/DSV is, before you edit or query it"
  homepage "https://excelano.com/xray/"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.5.2/x-ray-aarch64-apple-darwin.tar.xz"
      sha256 "2a36529954954b631a32bec3842c135073f9edade6ebd7ea7fccc3dfa21403c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.5.2/x-ray-x86_64-apple-darwin.tar.xz"
      sha256 "2f25b8b5e12050761c865ba56233316b81169e573b040724dd249a51e8ad7804"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xray/releases/download/v0.5.2/x-ray-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "233da1e64704a483f55674f4ec134bd3711b0ab900970fc0980ab9809ccce602"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xray/releases/download/v0.5.2/x-ray-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb024cf4f7a851f7dca1f701097fd990625e8b4a7e1be0936baaa37c2e328ed0"
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
