cask "requests-and-offers" do
  # v0.6.0-alpha.1 - Alpha Baseline: exchange record, hREA integration, Holochain 0.6.1
  version "0.6.0-alpha.1"

  on_arm do
    sha256 "260a5ce1ff35ea7e1fd4baeb661f35bc17884c3fcf820705a8c3aa1ada3d401b"

    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "a5557d17fdefe76b94e52a8e0f33ad2309728e350f61219f4a5f64ff8ca7ed44"

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
