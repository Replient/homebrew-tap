# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.2 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.2/knwlge-enterprise-1.1.2-darwin-arm64.tar.gz"
      sha256 "9a477d48c34094ddcf573e64849a916ac1bef02fd2a4e37d9ad3abaefcce7ae6"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.2/knwlge-enterprise-1.1.2-darwin-x64.tar.gz"
      sha256 "80122f19684b2b6955bd020a8429c3d4348c2787c54a732eaf218703be1c32ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.2/knwlge-enterprise-1.1.2-linux-arm64.tar.gz"
      sha256 "e94a8732d9233d1407eecb8f1425395e256d57059bd45aa07a2aed7b77c861bc"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.2/knwlge-enterprise-1.1.2-linux-x64.tar.gz"
      sha256 "748df6aff816977d3c4eaa87ebbfb9829718670f53ad304ac890ad5a2d2135f2"
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
