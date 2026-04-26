class Gitai < Formula
  desc "Track which lines of code were written by AI"
  homepage "https://github.com/elkidd/ai-blame"
  url "https://github.com/elkidd/ai-blame/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "70321bcc1de8710019567576e817f7bcd1811a51028271b876c332f7de13fd17"
  license "MIT"
  head "https://github.com/elkidd/ai-blame.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    s = <<~EOS
      Run 'gitai install' to set up Copilot CLI agent hooks.
    EOS
    unless Dir.exist?(File.expand_path("~/.copilot"))
      s += <<~EOS

        ⚠️  ~/.copilot not found. Install GitHub Copilot CLI first:
            npm install -g @anthropic-ai/claude-code
            or visit https://github.com/github/copilot-cli
      EOS
    end
    s
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitai --version")
  end
end
