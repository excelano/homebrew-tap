class Nved < Formula
  desc "Terminal text editor that edits in your scrollback like a REPL"
  homepage "https://excelano.com/nved/"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/nved/releases/download/v1.1.0/nved_1.1.0_darwin_arm64.tar.gz"
      sha256 "02708e963c194f258fe83758017ff4ff3d6d254ac6337ad4d8047b1da9637fe3"
    end
    on_intel do
      url "https://github.com/excelano/nved/releases/download/v1.1.0/nved_1.1.0_darwin_amd64.tar.gz"
      sha256 "676dc9ab4d2fe7b80a72d7970963aff4f739d60cac9eb25dc77e5b24a5068573"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/nved/releases/download/v1.1.0/nved_1.1.0_linux_arm64.tar.gz"
      sha256 "20ff4930fc1c09a0c9d47c1bad67d247b338e53edb74e1388bebb6fdf11e7095"
    end
    on_intel do
      url "https://github.com/excelano/nved/releases/download/v1.1.0/nved_1.1.0_linux_amd64.tar.gz"
      sha256 "5aef9fb9ddebea344274fe9be7a3caca0325d12bd141faffa27ac0077ac8212f"
    end
  end

  def install
    bin.install "nved"
  end

  test do
    system "#{bin}/nved", "--version"
  end
end
