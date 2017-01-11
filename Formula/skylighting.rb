class Skylighting < Formula
  include Language::Haskell::Cabal

  desc "Syntax highlighting tool with tokenizers derived from KDE syntax"
  homepage "https://github.com/jgm/skylighting"
  url "https://hackage.haskell.org/package/skylighting-0.1.0.1/skylighting-0.1.0.1.tar.gz"
  sha256 "e7cdbea2909306f97135b4444489cfff0136ec5609c22228a68201440d6304ac"

  head "https://github.com/jgm/skylighting.git"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build

  def install
    install_cabal_package "-fexecutable",
                          :using => ["happy"]
  end

  test do
    test_input = "*hello, world*\n"
    test_output = `/bin/echo -n "#{test_input}" | #{bin}/skylighting --syntax=markdown`
    test_output_last_line = test_output.split("\n")[-1]
    expected_last_line = '</style></head><body><div class="sourceCode"><pre class="sourceCode"><code class="sourceCode">*hello, world*</code></pre></div></body></html>'
    assert_equal expected_last_line, test_output_last_line
  end
end
