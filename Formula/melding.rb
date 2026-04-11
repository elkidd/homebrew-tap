class Melding < Formula
  desc "Command-line tool to send macOS user notifications"
  homepage "https://github.com/elkidd/melding"
  url "https://github.com/elkidd/melding/releases/download/v1.0.0/melding-1.0.0.zip"
  sha256 "08e833d573199ea778321b3623da19a40acf42a3eec6df9c4589f7f1b2b80a46"
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
