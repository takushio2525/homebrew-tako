cask "tako" do
  version "0.8.40"
  sha256 "b4af81cada6c201c1f4569ae60a17a1fbf2033ddc0caa193622b9792b620197a"

  url "https://github.com/takushio2525/tako/releases/download/v#{version}/tako-v#{version}-macos-arm64.zip"
  name "tako"
  desc "AI-driven terminal for agent-intensive monitoring"
  homepage "https://github.com/takushio2525/tako"

  depends_on macos: :big_sur

  app "tako.app"

  binary "#{appdir}/tako.app/Contents/MacOS/tako"

  # brew uninstall --zap で消す置き場。data dir は tako-core::paths::MACOS_DATA_DIR_REL と同じ
  # （正本は takushio2525/tako の distribution/homebrew-cask-draft.rb。番犬が突き合わせる。#2788）
  zap trash: [
    "~/Library/Application Support/tako",
    "~/Library/Caches/dev.takushio.tako",
    "~/Library/HTTPStorages/dev.takushio.tako",
    "~/Library/HTTPStorages/dev.takushio.tako.binarycookies",
    "~/Library/Preferences/dev.takushio.tako.plist",
    "~/Library/Saved Application State/dev.takushio.tako.savedState",
    "~/Library/WebKit/dev.takushio.tako",
  ]

  caveats <<~EOS
    tako CLI が #{HOMEBREW_PREFIX}/bin/tako にリンクされました。

    Claude Code 連携（初回 1 回）:
      claude mcp add --scope user tako -- #{appdir}/tako.app/Contents/MacOS/tako mcp serve

    tako を消すときは、先に tako setup undo で連携（MCP 登録など）を外してください（データは残ります）。

    Gatekeeper の警告が出た場合（未署名のため初回のみ必要）:
      xattr -dr com.apple.quarantine #{appdir}/tako.app
  EOS
end
