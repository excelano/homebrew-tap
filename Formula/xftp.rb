class Xftp < Formula
  desc "FTP-style interactive client for SharePoint document libraries"
  homepage "https://excelano.com/xftp/"
  version "1.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xftp_1.5.0_darwin_arm64.tar.gz"
      sha256 "7a623b541b2300afd6483c0f2018df34160d555342b8ac1df83f307a634d7296"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xftp_1.5.0_darwin_amd64.tar.gz"
      sha256 "c22a753fbf0bc52b1ad0741133aa8172d9b8e387005668a0d760715169473615"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xftp_1.5.0_linux_arm64.tar.gz"
      sha256 "f977e5766f0c5d8f283a863cf17d6be545af86ac5646b0aeeb2ec2e623f16a6b"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xftp_1.5.0_linux_amd64.tar.gz"
      sha256 "955bdc98d5c58c369806a36814940e3956696d4eb7b6924d70cbe8d585e91bad"
    end
  end

  def install
    bin.install "xftp"
  end

  test do
    system "#{bin}/xftp", "--version"
  end
end
