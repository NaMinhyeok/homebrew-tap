class AutoNamingCapture < Formula
  desc "macOS screenshot auto-renaming using OCR + AI (Claude/Codex)"
  homepage "https://github.com/NaMinhyeok/auto-naming-capture"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/NaMinhyeok/auto-naming-capture/releases/download/v0.1.0/auto-naming-capture-darwin-arm64.tar.gz"
    sha256 "7ae62afc6df9d07d4bd8ebc8763e3e2ddde644c0a30d7e029b9214d67cf2cf49"
  end

  on_intel do
    url "https://github.com/NaMinhyeok/auto-naming-capture/releases/download/v0.1.0/auto-naming-capture-darwin-amd64.tar.gz"
    sha256 "2f0fef8ce392e1426a86aff07c1e549d3bf3cd68970fd60191d663415ded5f68"
  end

  depends_on :macos

  def install
    # prefix에 원본 구조 유지: auto-naming-capture + ocr-helper/ocr-helper
    # Go의 os.Executable()이 symlink를 resolve하므로 상대 경로 탐색이 동작함
    prefix.install "auto-naming-capture"
    (prefix/"ocr-helper").mkpath
    (prefix/"ocr-helper").install "ocr-helper/ocr-helper"
    bin.install_symlink prefix/"auto-naming-capture"
  end

  def caveats
    <<~EOS
      Requires Claude CLI or Codex CLI:
        Claude: https://github.com/anthropics/claude-code
        Codex:  https://github.com/openai/codex

      Run the menu bar app:
        auto-naming-capture
    EOS
  end

  test do
    assert_predicate bin/"auto-naming-capture", :exist?
  end
end
