class GupnpAv < Formula
  desc "Library to help implement UPnP A/V profiles"
  homepage "https://wiki.gnome.org/GUPnP/"
  url "https://download.gnome.org/sources/gupnp-av/0.12/gupnp-av-0.12.11.tar.xz"
  sha256 "689dcf1492ab8991daea291365a32548a77d1a2294d85b33622b55cca9ce6fdc"
  revision 2

  bottle do
    sha256 arm64_big_sur: "3e52333c72d83f4c403225a56687a9cdbb51e8f546d207d8d0cb56cbeafb43f0"
    sha256 big_sur:       "bc30eb6638541401da64805ddbdf10303a1908ab3393cb7b6c73c199f853ca90"
    sha256 catalina:      "6e0cf541932104a1259005b3d125d96c72c80e2dffc7d8d4b5ddb199c7bdd237"
    sha256 mojave:        "15f5c2ec832094d098ebbc52c1a327ce7e6125293180e7acc377bc7dcc3d5210"
    sha256 high_sierra:   "7149d11d69541003e8fc3b1d0da0b125b6dac5329db3017a735858363f31e78c"
    sha256 sierra:        "dc21d3e8e793fffde5b7b734be587f3a736f94f03f8bfa42ca5ae395be6081a3"
    sha256 x86_64_linux:  "83ac17867733bca2be3a0b7f85b6c499568860056ae815bb9d42ab0ea1d9d095"
  end

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"

  def install
    ENV["ax_cv_check_cflags__Wl___no_as_needed"] = "no"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
