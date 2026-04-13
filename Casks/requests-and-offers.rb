cask "requests-and-offers" do
<<<<<<< HEAD
  # v0.5.1 - Active Link Management Patch
  version "0.5.1"

  if Hardware::CPU.arm?
    sha256 "b1af6814f35243e69cab3a5abebbf7c9a911d29b3541192c5d85857b08b3a2ba"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "6b1bb90eb33778be592a96a5474cdb4387d637e754ac7f993fa94ce733c5bc70"
=======
  # v0.5.0 - Progenitor Pattern & Sweettest Testing Release
  version "0.5.0"

  if Hardware::CPU.arm?
    sha256 "63765fa6489043b4a78fc7bcd98b9a97f4a8e56c004b0a525e9e4cb283128af7"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "e6b9bbfb8d850c53e706ea9b503643124a4ad729b51766d99cc81942458650cf"
>>>>>>> dbf6d13 (v0.5.0: update formula with new release checksums)
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
