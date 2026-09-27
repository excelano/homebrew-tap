class Plene < Formula
  desc "Shows Rust source alongside an expanded transcription: the same code with abbreviations and symbols written out in words"
  homepage "https://excelano.com/plene/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/plene/releases/download/v0.1.0/plene-aarch64-apple-darwin.tar.xz"
      sha256 "5887220671cc79a5085454d2fcf83226c619ee8deaa30987d264eb1af204be3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/plene/releases/download/v0.1.0/plene-x86_64-apple-darwin.tar.xz"
      sha256 "7799205fc904a021005a353dd5e98425a5b4b90bf6efb48380287325bc0d0bd7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/plene/releases/download/v0.1.0/plene-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28084b4cd05cf126031ff37d1c6cc19610ebf1fdcdb2c2ba1c363f4b0c8ab18e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/plene/releases/download/v0.1.0/plene-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba74a152a0001c84e6220c8b462d41afcdf48ad1037d94d02c968ec5772fe6b6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "plene"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "plene"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "plene"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "plene"
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
