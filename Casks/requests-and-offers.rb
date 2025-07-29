cask "requests-and-offers" do
  version "0.1.0-alpha.5"
  
  if Hardware::CPU.arm?
    sha256 :no_check  # Will be updated when DMGs are available
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 :no_check  # Will be updated when DMGs are available
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-x64.dmg"
  end
  
  name "Requests and Offers"
  desc "Holochain app for community requests and offers exchange"
  homepage "https://github.com/happenings-community/requests-and-offers"

  app "Requests and Offers.app"

  # Auto-remove quarantine for better UX
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
