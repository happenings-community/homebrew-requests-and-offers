cask "requests-and-offers" do
  # v0.1.8 with critical bug fix and production bootstrap server (https://holostrap.elohim.host/)
  version "0.1.8"
  
  if Hardware::CPU.arm?
    sha256 "801d9b58c88d657d07eb80a3cced5a64f80c596db5070e2e9818040ddab63b54"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "a3f22c9d7969d4397d3a70e4af306cc55407de01021ec045c75bb48f8dfbfba1"
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