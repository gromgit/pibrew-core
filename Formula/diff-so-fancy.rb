class DiffSoFancy < Formula
  desc "Good-lookin' diffs with diff-highlight and more"
  homepage "https://github.com/so-fancy/diff-so-fancy"
  url "https://github.com/so-fancy/diff-so-fancy/archive/v1.4.1.tar.gz"
  sha256 "65e3ce6c457445d017ac12de347b1f49d3a3df8ca158060792098c8b8cfe1b97"
  license "MIT"
  head "https://github.com/so-fancy/diff-so-fancy.git", branch: "next"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3cbecf7fd140ac394083519f08fc34fbf9223913e9573eb779b43e54eee0d1de"
  end

  def install
    libexec.install "diff-so-fancy", "lib"
    bin.install_symlink libexec/"diff-so-fancy"
  end

  test do
    diff = <<~EOS
      diff --git a/hello.c b/hello.c
      index 8c15c31..0a9c78f 100644
      --- a/hello.c
      +++ b/hello.c
      @@ -1,5 +1,5 @@
       #include <stdio.h>

       int main(int argc, char **argv) {
      -    printf("Hello, world!\n");
      +    printf("Hello, Homebrew!\n");
       }
    EOS
    assert_match "modified: hello.c", pipe_output(bin/"diff-so-fancy", diff, 0)
  end
end
