class Xtree < Formula
  desc "Show SharePoint document libraries as a tree, like tree"
  homepage "https://excelano.com/xftp/"
  version "1.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xtree_1.5.0_darwin_arm64.tar.gz"
      sha256 "4bb42ce35883cc0c37fb7cf5c48188c51bfc9011317cb656c81464367aebb18c"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xtree_1.5.0_darwin_amd64.tar.gz"
      sha256 "beddfeed9a7ba2dc5ad2a43e32bf30d5f13027b8cbab847a77cb7322cc77f832"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xtree_1.5.0_linux_arm64.tar.gz"
      sha256 "baac8877f5e7a6207a0175562fe3565b494cdb71dd5ba512d349001628cf21f1"
    end
    on_intel do
      url "https://github.com/excelano/xfiles/releases/download/v1.5.0/xtree_1.5.0_linux_amd64.tar.gz"
      sha256 "097b67937a3b4e7d53c7cc56a01e28e0c95802a1da8e8f42bba521ec347aae55"
    end
  end

  def install
    bin.install "xtree"
  end

  test do
    system "#{bin}/xtree", "--version"
  end
end
