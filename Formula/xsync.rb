class Xsync < Formula
  desc "Sync local directories with SharePoint document libraries"
  homepage "https://excelano.com/xftp/"
  version "1.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xsync_1.5.0_darwin_arm64.tar.gz"
      sha256 "fcf3aee744823daef93d931d4722020d856a0cfbc6a80769e4e7b0987652c55d"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xsync_1.5.0_darwin_amd64.tar.gz"
      sha256 "e0ac4daaa1ffe4f1f980cc2883f84cdac1bb8558f6e7a778cd0823029c3f7764"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xsync_1.5.0_linux_arm64.tar.gz"
      sha256 "9be7a44df5238e419b86861f1ea5f33c314c3fb77938a075b7c7291eb08739ac"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xsync_1.5.0_linux_amd64.tar.gz"
      sha256 "cc486a58e51c827894fe6dfba762369932b79a823d5f504baaaf923cf7a19dde"
    end
  end

  def install
    bin.install "xsync"
  end

  test do
    system "#{bin}/xsync", "--version"
  end
end
