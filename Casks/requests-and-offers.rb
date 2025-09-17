cask "requests-and-offers" do
  # v0.1.0-alpha.7 with production bootstrap server (https://holostrap.elohim.host/)
  version "0.1.0-alpha.7"
  
  if Hardware::CPU.arm?
    sha256 "e67cb541a9164e09814b95b8aa2c19226ae00e229fad5ccdcf5e3a3b6cd45036"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "3e5da4b80fda136d89a811ed296886e68b1f2d13ecf6e494a0d39ddcf2e7f33b"
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