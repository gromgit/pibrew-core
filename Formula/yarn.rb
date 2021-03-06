class Yarn < Formula
  desc "JavaScript package manager"
  homepage "https://yarnpkg.com/"
  # Should only be updated if the new version is listed as a stable release on the homepage
  url "https://yarnpkg.com/downloads/1.22.10/yarn-v1.22.10.tar.gz"
  sha256 "7e433d4a77e2c79e6a7ae4866782608a8e8bcad3ec6783580577c59538381a6e"
  license "BSD-2-Clause"

  livecheck do
    skip("1.x line is frozen and features/bugfixes only happen on 2.x")
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2e94245b589438a4f9dbce64edace8b237feb1ffadd0865bb21d6093a818d230"
  end

  depends_on "node"

  conflicts_with "hadoop", because: "both install `yarn` binaries"

  def install
    libexec.install Dir["*"]
    (bin/"yarn").write_env_script "#{libexec}/bin/yarn.js",
      PREFIX:            HOMEBREW_PREFIX,
      NPM_CONFIG_PYTHON: "/usr/bin/python"
    (bin/"yarnpkg").write_env_script "#{libexec}/bin/yarn.js",
      PREFIX:            HOMEBREW_PREFIX,
      NPM_CONFIG_PYTHON: "/usr/bin/python"
    inreplace "#{libexec}/lib/cli.js", "/usr/local", HOMEBREW_PREFIX
    inreplace "#{libexec}/package.json", '"installationMethod": "tar"', '"installationMethod": "homebrew"'
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"yarn", "add", "jquery"
    on_macos do
      # macOS specific package
      system bin/"yarn", "add", "fsevents", "--build-from-source=true"
    end
  end
end
