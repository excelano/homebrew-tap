class Waddle < Formula
  desc "Write ODT and DOCX from DocLang and docling JSON"
  homepage "https://github.com/excelano/waddle"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.1.1/waddle-aarch64-apple-darwin.tar.xz"
      sha256 "0426e6110d156f5d899e54744144c621e317dc74540457f5b8cec35f38e3101c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.1.1/waddle-x86_64-apple-darwin.tar.xz"
      sha256 "dc312bc7dbb506b629f27667bea1c643e6b000d25f1646a490700a54df1d3e5c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/waddle/releases/download/v0.1.1/waddle-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78ddfbec3a077b35578e0ba16908b0f552106d09ea493ad18bb08fa99b16c036"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/waddle/releases/download/v0.1.1/waddle-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47a669b570ba3bce52841ca2a092d46ff61485adc895723800c9c00d289b4fef"
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
      bin.install "waddle"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "waddle"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "waddle"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "waddle"
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
