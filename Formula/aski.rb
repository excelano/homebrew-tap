class Aski < Formula
  desc "one-shot questions for command-line LLMs — no quotes, no follow-up"
  homepage "https://github.com/excelano/aski"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/aski/releases/download/v0.2.0/aski-aarch64-apple-darwin.tar.xz"
      sha256 "824c1948c600da4b7f2ed7246b2b49734a33a2ad2f2f1c34cea26b5fef0ced46"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/aski/releases/download/v0.2.0/aski-x86_64-apple-darwin.tar.xz"
      sha256 "0a7445f5319d03d746aa73f01c1c60fab457e3e5fc2464d687e78194e2966a75"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/excelano/aski/releases/download/v0.2.0/aski-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aae85231abc8886c27f4e25a17f15cbd286e60820425e93cbe850adff80f824a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/excelano/aski/releases/download/v0.2.0/aski-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19ba3bbaa950d71508fb5fda9a7a2da0cbe392054aca4a90299979926e11e140"
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
      bin.install "aski"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "aski"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "aski"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "aski"
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
