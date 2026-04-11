class Melding < Formula
  desc "Command-line tool to send macOS user notifications"
  homepage "https://github.com/elkidd/melding"
  url "https://github.com/elkidd/melding/releases/download/v1.0.1/melding-1.0.1.zip"
  sha256 "c987ae4de2f026024b27254e26cfe58ac035c99b8fca43b6102d14010aeb23ed"
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
