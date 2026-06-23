class Xcp < Formula
  desc "Copy files to and from SharePoint document libraries, like cp"
  homepage "https://excelano.com/xftp/"
  version "1.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xcp_1.5.0_darwin_arm64.tar.gz"
      sha256 "0fe9068809bcc96d8e6ae02705aadeec1134f96762b8e01e4c455dc072f290b7"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xcp_1.5.0_darwin_amd64.tar.gz"
      sha256 "d5873258d0b91b769424df1c5b9d539aa455e8fb059e47be77f7f24d03ba7495"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xcp_1.5.0_linux_arm64.tar.gz"
      sha256 "1e6d9d0edf00aa0b1a42d9fa2c9550ecb32ebfb365ed6c82123dafbe6605e78d"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xcp_1.5.0_linux_amd64.tar.gz"
      sha256 "b8c04d9bf8790e36b8e298a9dc401563232d64a8a0b8f8c257a6e8612e011fd3"
    end
  end

  def install
    bin.install "xcp"
  end

  test do
    system "#{bin}/xcp", "--version"
  end
end
