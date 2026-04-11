class Melding < Formula
  desc "Command-line tool to send macOS user notifications"
  homepage "https://github.com/elkidd/melding"
  url "https://github.com/elkidd/melding/releases/download/v1.0.4/melding-1.0.4.zip"
  sha256 "3f32d866d27d9b04588757d1b013e46a4c8ec78833659401a30e1d1076098ac3"
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
