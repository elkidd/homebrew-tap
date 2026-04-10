class Melding < Formula
  desc "Command-line tool to send macOS user notifications"
  homepage "https://github.com/elkidd/melding"
  url "https://github.com/elkidd/melding/releases/download/v1.0.0/melding-1.0.0.zip"
  sha256 "562075d3fe2c593de1a529e15b96ec2e7c75f9fec5c29275c7c05af7bf57cd5d"
  license "MIT"

  def install
    libexec.install "melding.app"
    (bin/"melding").write <<~EOS
      #!/bin/sh
      # Remove Gatekeeper quarantine on first run
      xattr -d com.apple.quarantine "#{libexec}/melding.app" 2>/dev/null || true
      exec "#{libexec}/melding.app/Contents/MacOS/melding" "$@"
    EOS
  end

  test do
    assert_match "melding", shell_output("#{bin}/melding --help")
  end
end
