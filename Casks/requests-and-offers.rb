cask "requests-and-offers" do
  # v0.1.10 with development network enhancements and improved user experience
  version "0.1.10"

  if Hardware::CPU.arm?
    sha256 "bf8aef2a3e2de736f8020def499c775511bd7dfbb6b18cb2489bd10bbb00ada8"
    url "https://github.com/holochain-apps/kangaroo-electron/releases/download/v#{version}/Requests-and-Offers-#{version}-arm64.dmg"
  else
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    url "https://github.com/holochain-apps/kangaroo-electron/releases/download/v#{version}/Requests-and-Offers-#{version}-x64.dmg"
  end

  name "Requests and Offers"
  desc "Holochain app for community requests and offers exchange"
  homepage "https://github.com/happenings-community/requests-and-offers"

  app "Requests and Offers.app"

  # Auto-remove quarantine for better UX
  # Native modules are now properly bundled in the app package
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/Requests and Offers.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/requests-and-offers.happenings-community.kangaroo-electron",
    "~/Library/Preferences/requests-and-offers.happenings-community.kangaroo-electron.plist",
    "~/Library/Logs/requests-and-offers.happenings-community.kangaroo-electron",
  ]
end
