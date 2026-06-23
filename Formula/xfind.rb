class Xfind < Formula
  desc "Find files in SharePoint document libraries, like find"
  homepage "https://excelano.com/xftp/"
  version "1.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xfind_1.5.0_darwin_arm64.tar.gz"
      sha256 "c88072ffefae0e2c4a9aabeb8a0e537758787dbb5fdfa272981f570d8df2d99b"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xfind_1.5.0_darwin_amd64.tar.gz"
      sha256 "a758f1dc21c72b1d3296f77d989cfc1f5018963b86a62a09b8fa019aff0b92b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xfind_1.5.0_linux_arm64.tar.gz"
      sha256 "0f353de379a950103eca733c350000f3694b1e5db9fbe849360607db0e25a0bf"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xfind_1.5.0_linux_amd64.tar.gz"
      sha256 "e610e90be32601364bcd5e37a841c1ccb5324e1585a04d30e9ae5e43a942d779"
    end
  end

  def install
    bin.install "xfind"
  end

  test do
    system "#{bin}/xfind", "--version"
  end
end
