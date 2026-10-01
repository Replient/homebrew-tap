# Homebrew formula template for the `knwlge` developer CLI.
#
# The release workflow (.github/workflows/release.yml) substitutes
# 1.0.0 and 7af2e7fcbd06ea445bcf626c3f1945afcb73f649a7a79609d9eca381d6ce53dc and commits the result to
# Formula/knwlge.rb on `main` of Replient/homebrew-tap. Do not edit the
# published formula by hand; change this template and cut a release.
class Knwlge < Formula
  desc "Knwlge developer CLI: sign in to a Knwlge Enterprise Server and wire AI coding assistants to it"
  homepage "https://github.com/Replient/knwlge-cli"
  url "https://github.com/Replient/knwlge-releases/releases/download/cli-v1.0.0/knwlge-1.0.0.tgz"
  sha256 "7af2e7fcbd06ea445bcf626c3f1945afcb73f649a7a79609d9eca381d6ce53dc"
  version "1.0.0"
  license :cannot_represent

  depends_on "node@22"

  def install
    # The tarball is self-contained (every runtime dependency is bundled), so
    # `npm install` needs no registry access; std_npm_args installs it under
    # libexec and links nothing outside the keg.
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/knwlge --version").strip
    assert_equal version.to_s, shell_output("#{bin}/team-context --version").strip
    assert_match "knwlge init --api-url", shell_output("#{bin}/knwlge --help")
  end
end
