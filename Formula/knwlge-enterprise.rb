# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.3 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.3/knwlge-enterprise-1.1.3-darwin-arm64.tar.gz"
      sha256 "dee1b68aa912da023262325f925356d3f8974302b14765c3d7d0f9f70279207c"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.3/knwlge-enterprise-1.1.3-darwin-x64.tar.gz"
      sha256 "f8ed7a6a5350d454edb51f925e1b7e425ed3976ddbdfcba0b58c71ebded2b92f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.3/knwlge-enterprise-1.1.3-linux-arm64.tar.gz"
      sha256 "232f827e636f8f1ce85a3009f817aefdc1b1614e3610dc8b7869a477a64cbf86"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.3/knwlge-enterprise-1.1.3-linux-x64.tar.gz"
      sha256 "525ad1aeb5606dd94b0e3ee333f280f43d0a37508312ec44c3110a8db7ac90a9"
    end
  end

  def install
    # The tarball is self-contained: bin/knwlge-enterprise (launcher), libexec/node (Node.js)
    # and libexec/app (the application with its production dependencies). Keep it whole under
    # libexec and expose the launcher, which finds its own directory.
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"bin/knwlge-enterprise"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/knwlge-enterprise --version").strip
    assert_match "Usage: knwlge-enterprise", shell_output("#{bin}/knwlge-enterprise --help")
  end
end
