class Gitai < Formula
  desc "Track which lines of code were written by AI"
  homepage "https://github.com/elkidd/ai-blame"
  url "https://github.com/elkidd/ai-blame/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER"
  license "MIT"
  head "https://github.com/elkidd/ai-blame.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def post_install
    ohai "Run 'gitai install' to set up Copilot CLI agent hooks"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitai --version")
  end
end
