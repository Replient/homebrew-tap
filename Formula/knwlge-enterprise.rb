# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.7 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.7"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.7/knwlge-enterprise-1.1.7-darwin-arm64.tar.gz"
      sha256 "9200cfa910fa6b15fe5702ca279396aea6316d0c62a426261e12a0ebb343b69f"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.7/knwlge-enterprise-1.1.7-darwin-x64.tar.gz"
      sha256 "0508f1f53c255740a3d48eceb91b5ac4c07429e217e2aabadb9b69f9477ed746"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.7/knwlge-enterprise-1.1.7-linux-arm64.tar.gz"
      sha256 "3be98f873e044a1fbdf27522a4297c957fa2281c1146a414461fe8edf3520706"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.7/knwlge-enterprise-1.1.7-linux-x64.tar.gz"
      sha256 "c3dfaea3734de2033f0c4c814facc0b1c64f87b714a90deaa0e045b09275ba66"
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
