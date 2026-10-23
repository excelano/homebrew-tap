class Xled < Formula
  desc "sed and awk for tabular data — regex transforms over Excel-style ranges on CSV/DSV"
  homepage "https://excelano.com/xled/"
  version "0.13.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.13.1/xled-aarch64-apple-darwin.tar.xz"
      sha256 "913511ee278c79538fe62c7080cc3b27a09764dc12e4982be2698ac03fd71b59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.13.1/xled-x86_64-apple-darwin.tar.xz"
      sha256 "0b4fb3889d900858c2331705ba84d249be307f90fefaee196d51819de8195c4a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/xled/releases/download/v0.13.1/xled-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bcacf81919eaccd1015ef4f8dda798ad2f59a6c41ac0652783d6c174d112d3c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/xled/releases/download/v0.13.1/xled-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "228444fdc1a13e326206ec498de532ec07131f2ee301291003d0f727e7a4e42a"
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
      bin.install "xled"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "xled"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "xled"
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
