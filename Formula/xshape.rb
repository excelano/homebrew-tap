class Xshape < Formula
  desc "reshape tabular data — pivot, unpivot, split, merge, explode, transpose — without touching a value"
  homepage "https://excelano.com/xshape/"
  version "0.5.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.4/xshape-aarch64-apple-darwin.tar.xz"
      sha256 "4dd4cd8edbe1bdb40e751712371d9adf8486a565d87f1d6090e9898f8e4da047"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.4/xshape-x86_64-apple-darwin.tar.xz"
      sha256 "52889200b677f014bbaf6046aea729c4fabfbc64d6414a930703e6ab87e560f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xshape/releases/download/v0.5.4/xshape-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "30cd9910accc840a156e784c0221e89cb61e1e153e48ccadc8e519dde589eac5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xshape/releases/download/v0.5.4/xshape-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2fca7f5820fd060ad4798ac7049df2d90965e155e1d51f33cfa7613e34aedc7e"
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
