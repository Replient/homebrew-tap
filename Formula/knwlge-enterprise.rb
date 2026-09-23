# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.0 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.0/knwlge-enterprise-1.1.0-darwin-arm64.tar.gz"
      sha256 "ce57590228d2875c82845ea20039184755a630ecb4e740548376784228c8ada7"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.0/knwlge-enterprise-1.1.0-darwin-x64.tar.gz"
      sha256 "195c9ae2a832b6b67031b66d37637c12b86a4b77d11fad4f1191f7ec5bce2222"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.0/knwlge-enterprise-1.1.0-linux-arm64.tar.gz"
      sha256 "dc64c6ae6e085c23028c2ababb44572669ae6ca3cc3a9945aeb9f20180770a03"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.0/knwlge-enterprise-1.1.0-linux-x64.tar.gz"
      sha256 "09ffd724c95e0d909b7ac7a21e4a854f8c7c020cec860fc360a3429bf49da070"
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
