cask "requests-and-offers" do
  # v0.4.0 - Weave/Moss Integration & Markdown Support Release
  version "0.4.0"

  if Hardware::CPU.arm?
    sha256 "e825aad0d69d576ec9601c58bdf31bed9730cc06814ebcff15e461e41c207514"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "f9c7d67bb22fc3f517353d47d347d6ea5b76ef0a5cb200a12a6e805bd79da061"
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
