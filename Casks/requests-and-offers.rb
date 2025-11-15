cask "requests-and-offers" do
  # v0.2.0 - UI/UX Enhancement Release with improved responsiveness and administrative capabilities
  version "0.2.0"

  if Hardware::CPU.arm?
    sha256 "33f7a9a2cd93f6dc076dfc734eb5e80587fc04c1ebb56f5608203ca61ce67ecb"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "f8aecf81f0ef753a10d70f78c052b5b8e4391a560f6524fe26b7dd67cff9ec46"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-x64.dmg"
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
