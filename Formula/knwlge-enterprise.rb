# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.1 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.1/knwlge-enterprise-1.1.1-darwin-arm64.tar.gz"
      sha256 "33b123d329024001c25a198d5128ae07905b546c68f4835a907cdb3f1f5f03dd"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.1/knwlge-enterprise-1.1.1-darwin-x64.tar.gz"
      sha256 "ba100403cb33c34f546aeab6bc59447704b2750911505c9a3e9cdece739b8517"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.1/knwlge-enterprise-1.1.1-linux-arm64.tar.gz"
      sha256 "b539d5e86c10a239af1c089241265258876db12b1838af4357cfbbde5a6e9bb7"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.1/knwlge-enterprise-1.1.1-linux-x64.tar.gz"
      sha256 "d617d6da7a065357e81b62e9e196462b5b597e4b22fd606866b98e3cda2849a8"
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
