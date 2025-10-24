cask "requests-and-offers" do
  # v0.1.9 with cross-platform desktop integration and improved deployment infrastructure
  version "0.1.9"

  if Hardware::CPU.arm?
    sha256 "d57d63bec6862f7ccad380e5bcc491e489f6ee5a00b0289d69272d0b50f1550a"
    url "https://github.com/happenings-community/requests-and-offers-kangaroo-electron/releases/download/v#{version}/requests-and-offers.happenings-community.kangaroo-electron-#{version}-arm64.dmg"
  else
    sha256 "b7a8e45181ce47072a0f45f6e3875ad808c2c6d03cc6b3d0f648f208a43911dd"
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