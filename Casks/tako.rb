cask "tako" do
  version "0.2.3"
  sha256 "a34ba36c674c79e8405cb09ca08ce4be29fa6ca02c1f63a45b6736f64bfdc8aa"

  url "https://github.com/takushio2525/tako/releases/download/v#{version}/tako-v#{version}-macos-arm64.zip"
  name "tako"
  desc "AI-driven terminal for agent-intensive monitoring"
  homepage "https://github.com/takushio2525/tako"

  depends_on macos: :big_sur

  app "tako.app"

  binary "#{appdir}/tako.app/Contents/MacOS/tako"

  zap trash: [
    "~/Library/Application Support/dev.takushio.tako",
  ]

  caveats <<~EOS
    tako CLI が #{HOMEBREW_PREFIX}/bin/tako にリンクされました。

    Claude Code 連携（初回 1 回）:
      claude mcp add --scope user tako -- #{appdir}/tako.app/Contents/MacOS/tako mcp serve

    Gatekeeper の警告が出た場合（未署名のため初回のみ必要）:
      xattr -dr com.apple.quarantine #{appdir}/tako.app
  EOS
end
