class Bitrise < Formula
  desc "Command-line automation tool"
  homepage "https://github.com/bitrise-io/bitrise"
  url "https://github.com/bitrise-io/bitrise/archive/1.47.0.tar.gz"
  sha256 "d7055b194c76f412b5d9dcbbd50bcd7c7c2e3ef8f4688062116c870b352e68f4"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "a94206c6a98c3629c8e2ea34cfc07043c8fdc8a2a2e5d52f5d0d98cc5321cdbf"
    sha256 cellar: :any_skip_relocation, catalina:     "ef5697234a5dd2cb7605b35ae363f6261eed865fe83e607de442d8cf5198873c"
    sha256 cellar: :any_skip_relocation, mojave:       "878daf0cbca8925c338030ce07aab3ad7927653b3ea463443ee081ae0a1cec6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c0b1753657d288071a151321322a808cbb1c944d599a9d8db7806a79acfe274b"
  end

  depends_on "go" => :build
  depends_on "rsync" => :test

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    (testpath/"bitrise.yml").write <<~EOS
      format_version: 1.3.1
      default_step_lib_source: https://github.com/bitrise-io/bitrise-steplib.git
      workflows:
        test_wf:
          steps:
          - script:
              inputs:
              - content: printf 'Test - OK' > brew.test.file
    EOS

    system "#{bin}/bitrise", "setup"
    system "#{bin}/bitrise", "run", "test_wf"
    assert_equal "Test - OK", (testpath/"brew.test.file").read.chomp
  end
end
