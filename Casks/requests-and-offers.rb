cask "requests-and-offers" do
  # v0.6.0-alpha.1 - Alpha Baseline: exchange record, hREA integration, Holochain 0.6.1
  version "0.6.0-alpha.1"

  on_arm do
    sha256 "a191c38dba714a6549c70e9875b56a9690f1ba6ed2728b736677ce871fa0b2f0"

    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "dc7753be6675f7cc398a2a6bf37f6dfe200cdaecc03f4d035fd48c80ddbf27f8"

    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-x64.dmg"
  end

  name "Requests and Offers"
  desc "Holochain app for community requests and offers exchange"
  homepage "https://github.com/happenings-community/requests-and-offers"

  depends_on :macos

  app "Requests and Offers.app"

  # The app is not notarised, so remove the quarantine flag to stop Gatekeeper
  # blocking the first launch. Failure is ignored, as it was with `postflight`.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-r", "-d", "com.apple.quarantine", "{{appdir}}/Requests and Offers.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/requests-and-offers.happenings-community.kangaroo-electron",
    "~/Library/Logs/requests-and-offers.happenings-community.kangaroo-electron",
    "~/Library/Preferences/requests-and-offers.happenings-community.kangaroo-electron.plist",
  ]
end
