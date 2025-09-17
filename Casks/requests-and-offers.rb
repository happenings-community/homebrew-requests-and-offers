cask "requests-and-offers" do
  # v0.1.0-alpha.6 includes macOS native module fixes from August 25, 2025
  version "0.1.0-alpha.7"
  
  if Hardware::CPU.arm?
    sha256 "3219b599b6f8636da742b01b714d49f6b8b6c8ae702876e88c9bdf6b394b048a"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "9fedeca157e6f6887cac5eb2dd863da2241b528f67a152c7faa5840eb6f50834"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-x64.dmg"
  end
  
  name "Requests and Offers"
  desc "Holochain app for community requests and offers exchange"
  homepage "https://github.com/happenings-community/requests-and-offers"

  app "Requests and Offers.app"

  # Auto-remove quarantine and fix native modules for better UX
  postflight do
    # Remove quarantine
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/Requests and Offers.app"],
                   sudo: false
    
    # Fix native module issue with better error handling
    system_command "/bin/sh",
                   args: ["-c", <<~EOS
                     cd '#{appdir}/Requests and Offers.app/Contents/Resources' && \
                     if [ ! -d 'app.asar.unpacked/node_modules/@holochain/hc-spin-rust-utils' ]; then \
                       echo 'Installing missing native module...' && \
                       mkdir -p app.asar.unpacked/node_modules/@holochain && \
                       cd app.asar.unpacked && \
                       npm install --no-save @holochain/hc-spin-rust-utils@0.500.0 && \
                       echo 'Native module installation completed'; \
                     else \
                       echo 'Native module already present'; \
                     fi
                   EOS
                   ],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/requests-and-offers.happenings-community.kangaroo-electron",
    "~/Library/Preferences/requests-and-offers.happenings-community.kangaroo-electron.plist",
    "~/Library/Logs/requests-and-offers.happenings-community.kangaroo-electron",
  ]
end