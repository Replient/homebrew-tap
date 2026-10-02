# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.6 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.6"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.6/knwlge-enterprise-1.1.6-darwin-arm64.tar.gz"
      sha256 "0e5b2da490528b5c6264a74c31831ec5de0e9a078de2169e5e4607f45b34c691"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.6/knwlge-enterprise-1.1.6-darwin-x64.tar.gz"
      sha256 "8b18efbe24a524ddb351f0c855d07436f7ecdfb22378c23f85c2b3213ac6bc17"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.6/knwlge-enterprise-1.1.6-linux-arm64.tar.gz"
      sha256 "3d86d525c928f2e120911349f79dfcd780906b7407ab61c766d535864d416c34"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.6/knwlge-enterprise-1.1.6-linux-x64.tar.gz"
      sha256 "45c96df59d7d53742f91c31ab68ab9750c9dce7b83bd06832259d103db925140"
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
