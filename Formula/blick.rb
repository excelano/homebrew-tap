class Blick < Formula
  desc "Check Microsoft 365 mail, Teams chats, and next meeting from the terminal"
  homepage "https://excelano.com/blick-cli/"
  version "0.9.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/excelano/blick-cli/releases/download/v0.9.2/blick_0.9.2_darwin_arm64.tar.gz"
      sha256 "ecfbb97e1714733eb9261a1d71b312d6a5321442de908d5277bda5c7e8900e89"
    end
    on_intel do
      url "https://github.com/excelano/blick-cli/releases/download/v0.9.2/blick_0.9.2_darwin_amd64.tar.gz"
      sha256 "7fc3503a8e3cbd4e4554a6b9c9a8b3840661d4ce6af4095d5dae686df439e886"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/excelano/blick-cli/releases/download/v0.9.2/blick_0.9.2_linux_arm64.tar.gz"
      sha256 "59139ddc2af878bae25f8335e8556416a9692a99137838b5c8c363662d9a294a"
    end
    on_intel do
      url "https://github.com/excelano/blick-cli/releases/download/v0.9.2/blick_0.9.2_linux_amd64.tar.gz"
      sha256 "e2e2797fd10d29511b56e4aba2797297bc942ff9998d53cd4076b991e6a3e2e7"
    end
  end

  def install
    bin.install "blick"
  end

  test do
    system "#{bin}/blick", "--version"
  end
end
