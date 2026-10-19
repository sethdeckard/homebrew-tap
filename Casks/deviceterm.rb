# Homebrew cask template for deviceterm. `version` and `sha256` are
# placeholders: `scripts/publish-release.sh` renders this into the tap
# (sethdeckard/homebrew-tap → Casks/deviceterm.rb) at release time,
# filling `version` from DeviceTermVersion.swift and `sha256` from the
# notarized DMG. Don't hand-edit the copy in the tap; edit this
# template and re-run the publish step.
#
# Install:  brew install --cask sethdeckard/tap/deviceterm
cask "deviceterm" do
  version "0.14.0"
  sha256 "c47b3be2ec6bce869fe2074c30ffe40a8990da2a5484511251b3b9b063fc4b25"

  url "https://github.com/sethdeckard/deviceterm/releases/download/v#{version}/deviceterm-#{version}.dmg"
  name "DeviceTerm"
  desc "macOS-native terminal that runs live iOS Simulators as panes"
  homepage "https://deviceterm.com"

  # macOS 14+ (Sonoma), matching the app's LSMinimumSystemVersion.
  depends_on macos: :sonoma

  # In-app updates are handled by Sparkle; `brew upgrade` also works
  # (re-installs the DMG). Both are supported.
  auto_updates true

  app "DeviceTerm.app"

  # The embedded daemon registers as a login item via SMAppService; a cask
  # can't unregister it. `zap` only clears app data — see docs/RELEASING.md
  # for the manual login-item cleanup note.
  zap trash: [
    "~/Library/Application Support/deviceterm",
    "~/Library/Preferences/com.deviceterm.plist",
  ]
end
