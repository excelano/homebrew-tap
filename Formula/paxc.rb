class Paxc < Formula
  desc "A compiler for the pax DSL, producing Power Automate cloud flow definitions"
  homepage "https://excelano.com/paxc/"
  version "3.8.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.8.2/paxc-aarch64-apple-darwin.tar.xz"
      sha256 "48136fd8fa233d5b37dfc22d2b7e2bf9d74e14535bfd22923daa60c97bcc94f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.8.2/paxc-x86_64-apple-darwin.tar.xz"
      sha256 "db007a7d4bf1f4d1c14523bc51f9c40963ec7c64f5faa79d5a732199aeaab51c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/paxc/releases/download/v3.8.2/paxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca9020bcb0386a0869c70a89f280048df54aebe045951e6f8fe22ad243f33daa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/paxc/releases/download/v3.8.2/paxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4843eb6a7fb4e7055566038bc3c10923ccd740402cfd1541f4323f29ef21cd47"
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
    bin.install "paxc", "paxr" if OS.mac? && Hardware::CPU.arm?
    bin.install "paxc", "paxr" if OS.mac? && Hardware::CPU.intel?
    bin.install "paxc", "paxr" if OS.linux? && Hardware::CPU.arm?
    bin.install "paxc", "paxr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
