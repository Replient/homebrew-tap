# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.5 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.5/knwlge-enterprise-1.1.5-darwin-arm64.tar.gz"
      sha256 "120835324a6a159b60dbe0efe29b76eaa7cef6e2aa8a65427ebd0daf1267005f"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.5/knwlge-enterprise-1.1.5-darwin-x64.tar.gz"
      sha256 "fc9b3581dd9835a2d2d7c76936a41088954fa17fbc826cd6a347ffc1e94e9e9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.5/knwlge-enterprise-1.1.5-linux-arm64.tar.gz"
      sha256 "3b0de71974bad6bcd7b2d78b1fabca989ed153ba7ad0cda1fa5fcf7020cab287"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.5/knwlge-enterprise-1.1.5-linux-x64.tar.gz"
      sha256 "056e7c58d4f33290cc9f0951b157ad7412193cae51654e078e342fcf5155ecaa"
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
