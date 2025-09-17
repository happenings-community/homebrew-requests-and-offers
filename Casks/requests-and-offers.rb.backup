cask "requests-and-offers" do
  # v0.1.0-alpha.6 includes macOS native module fixes from August 25, 2025
  version "0.1.0-alpha.7"
  
  if Hardware::CPU.arm?
    sha256 "065e1e60b478a16520f9f4e517303cd07d775e5be71dae90abbb31db23f5ca6d"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "1f60e8f66a93b302257c58682bc0334aa9d647aa26bd12987917cccbb7f6b994"
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