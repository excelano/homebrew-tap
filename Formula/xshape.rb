class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.5.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.6/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "a23992ad703d0344e72964126d6f753544b75e2030bd361e8297f1d808f6109b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.6/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "8edda99c5c2cf937db43e05a5af5c813f5d766121ef2531f59736ccb890b230a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.6/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f87f5bfe5cf0a5d117745f2b374b82f42a45f60093963be6720aa70c9addeec2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.6/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0ffc82dcb096a89dc294eb98bbef682543fb4499fe2597d04a2a7ed8fc863f85"
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
      bin.install "xshape"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xshape"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xshape"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xshape"
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
