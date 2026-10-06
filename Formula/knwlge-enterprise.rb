# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.2.1 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.2.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.2.1/knwlge-enterprise-1.2.1-darwin-arm64.tar.gz"
      sha256 "be4868b1677e3c359c02f46230010c0eb1c62792c4005e07a96e6953e1ef2f38"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.2.1/knwlge-enterprise-1.2.1-darwin-x64.tar.gz"
      sha256 "6cabbe6bc0e53d07ec0eecc33ef2fb216978078db04d5c1c85194aa6b39bda6e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.2.1/knwlge-enterprise-1.2.1-linux-arm64.tar.gz"
      sha256 "e0a88d868995b589ad2fc579f02fc5d3635ef840e854b2e6204b65d303938874"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.2.1/knwlge-enterprise-1.2.1-linux-x64.tar.gz"
      sha256 "214007c5fa706cab6f22aaf5daf317e34abe20f7df2be5befce0f152cd0c3de0"
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
