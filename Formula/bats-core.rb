class BatsCore < Formula
  desc "Bash Automated Testing System"
  homepage "https://github.com/bats-core/bats-core"
  url "https://github.com/bats-core/bats-core/archive/v1.3.0.tar.gz"
  sha256 "1d5075e6e712dc15fbe818b9d88605dbc8908269857f054b046321a4b9cba089"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fae69721e6ec6a1b07e1d10699187640ef4e5e939460a496bd304d03beb08364"
  end

  depends_on "coreutils"

  uses_from_macos "bc" => :test

  conflicts_with "bats", because: "both install `bats` executables"

  def install
    system "./install.sh", prefix
    # Replace `/usr/local` references for uniform bottles
    inreplace lib/"bats-core/formatter.bash", "/usr/local", HOMEBREW_PREFIX
  end

  test do
    (testpath/"test.sh").write <<~EOS
      @test "addition using bc" {
        result="$(echo 2+2 | bc)"
        [ "$result" -eq 4 ]
      }
    EOS
    assert_match "addition", shell_output("#{bin}/bats test.sh")
  end
end
