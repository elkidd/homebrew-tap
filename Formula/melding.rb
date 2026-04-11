class Melding < Formula
  desc "Command-line tool to send macOS user notifications"
  homepage "https://github.com/elkidd/melding"
  url "https://github.com/elkidd/melding/releases/download/v1.0.0/melding-1.0.0.zip"
  sha256 "59aa0b4953141b28f01a42d7043bab5621b7aadbc9351d2c34dc7fb41e7c474a"
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
