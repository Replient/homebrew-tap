# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.8 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.8/knwlge-enterprise-1.1.8-darwin-arm64.tar.gz"
      sha256 "022cf439277e1ff634defcf221520ea83e1c895f88a4437c5b8b526f5d4cc9a3"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.8/knwlge-enterprise-1.1.8-darwin-x64.tar.gz"
      sha256 "a19f4b34451e74fdb1ea70f566d80db62b583a07807293f9a5150308438b0a7f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.8/knwlge-enterprise-1.1.8-linux-arm64.tar.gz"
      sha256 "c406ccb841bca3c9f87a5cec6bb592432d5986844ef95a60362349c1a52ef064"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.8/knwlge-enterprise-1.1.8-linux-x64.tar.gz"
      sha256 "7fd70c9bea2829c2dfee386a1eff6e73403b22932916a515dc21e61768dbda77"
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
