# The macOS channel for slipcase-open: a notarized Developer ID bundle, from
# the zip attached to each GitHub release. `packaging/macos/README.md` in that
# repository says why it is not the Mac App Store.
#
# Author: David M. Anderson
# Built with AI assistance (Claude, Anthropic)
cask "slipcase-open" do
  version "0.2.2"
  sha256 "b2ed96e92cb05f5538e69ea220999dabd23092d4d7156050552f03bceea29a4b"

  url "https://github.com/excelano/slipcase-open/releases/download/v#{version}/slipcase-open-#{version}-macos.zip"
  name "Slipcase Open"
  desc "Open a Slipcase container's payload in its own app and write edits back"
  homepage "https://github.com/excelano/slipcase-open"

  depends_on macos: :big_sur

  app "Slipcase Open.app"
  # The command line is a shipped interface and not only the launcher's
  # helper, so it goes on PATH under its own name.
  binary "#{appdir}/Slipcase Open.app/Contents/MacOS/slipcase-open"
  manpage "slipcase-open.1"

  # Sessions live here, and a session may hold an edit that was never written
  # back into its container. `brew uninstall` leaves them; only `--zap`
  # removes them, and this comment is the warning.
  zap trash: "~/Library/Application Support/slipcase-open"
end
