# Homebrew formula template for the Knwlge Enterprise Server.
#
# scripts/release/render-formula.mjs substitutes 1.1.4 and the four __SHA256_*__
# placeholders from a release's checksums.txt; the release workflow commits the result to
# Formula/knwlge-enterprise.rb on `main` of Replient/homebrew-tap. Do not edit the published
# formula by hand; change this template and cut a release.
class KnwlgeEnterprise < Formula
  desc "Source-backed context server for AI coding assistants, run on your own machine"
  homepage "https://knwlge.com"
  version "1.1.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.4/knwlge-enterprise-1.1.4-darwin-arm64.tar.gz"
      sha256 "6fc0bd4352c99fdf3ce527005d41dbcc9e047245e2bb4fc8178e352b66bbce85"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.4/knwlge-enterprise-1.1.4-darwin-x64.tar.gz"
      sha256 "a142b45cba9b73e114565c34193819e67af8e0308c0d9f1cf16f5922d33fce83"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.4/knwlge-enterprise-1.1.4-linux-arm64.tar.gz"
      sha256 "e99f391cb19b33044b82cd482f400c7944d80577cf82624e5aa683053a97a65f"
    end
    on_intel do
      url "https://github.com/Replient/knwlge-releases/releases/download/enterprise-v1.1.4/knwlge-enterprise-1.1.4-linux-x64.tar.gz"
      sha256 "51c20b257aa7ec51c885b28d3a290a55d428e4385cb249dd25836c0bcf294215"
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
