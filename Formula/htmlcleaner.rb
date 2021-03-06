class Htmlcleaner < Formula
  desc "HTML parser written in Java"
  homepage "https://htmlcleaner.sourceforge.io"
  url "https://downloads.sourceforge.net/project/htmlcleaner/htmlcleaner/htmlcleaner%20v2.24/htmlcleaner-2.24-src.zip"
  sha256 "ee476c1f31eabcbd56c174ec482910e1b19907ad3e57dff9a4d0a2f456c9cd42"
  license "BSD-3-Clause"
  revision 1

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f589e5b99a7d2443607e863555978b07e7c6fe30d9e7c8b536583dfcf87713e4"
    sha256 cellar: :any_skip_relocation, big_sur:       "e2d3b97f42d5d1442dc129bc32f56db6319caf5a58c54946f498862cf03b474f"
    sha256 cellar: :any_skip_relocation, catalina:      "1676af315722a63de9c45daf78e747fd2653e72682bf6c8cb3a22c5262f762d4"
    sha256 cellar: :any_skip_relocation, mojave:        "112f63a58175f8ab10dc077490a4704a18cefe190fb617f511a441f391cdbeac"
    sha256 cellar: :any_skip_relocation, high_sierra:   "af704dd8dba231d424e0145132f4dab9c93c94d8699267eb3eace5fe90e57623"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "022dbb9460409292d8121848b864b3f9191b5c1f2cb446776cd1c2eea84292ec"
  end

  depends_on "maven" => :build
  depends_on "openjdk"

  def install
    ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix

    inreplace "pom.xml" do |s|
      # Homebrew's OpenJDK no longer accepts Java 5 source
      s.gsub! "<source>1.5</source>", "<source>1.7</source>"
      s.gsub! "<target>1.5</target>", "<target>1.7</target>"
      # OpenJDK >14 doesn't support older maven-javadoc-plugin versions
      s.gsub! "<version>2.9</version>", "<version>3.2.0</version>"
    end

    system "mvn", "clean", "package", "-DskipTests=true", "-Dmaven.javadoc.skip=true"
    libexec.install Dir["target/htmlcleaner-*.jar"]
    bin.write_jar_script libexec/"htmlcleaner-#{version}.jar", "htmlcleaner"
  end

  test do
    path = testpath/"index.html"
    path.write "<html>"
    assert_match "</html>", shell_output("#{bin}/htmlcleaner src=#{path}")
  end
end
