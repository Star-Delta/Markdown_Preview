# Markdown_Preview

このプロジェクトは、ローカルのMarkdownファイル（`.md`）を**リアルタイムでプレビュー**するWebツールです。File System Access APIを活用して、選択したローカルフォルダ内のMarkdown・画像・Mermaid図を安全に読み取り、1秒ごとに自動更新して表示します。

## 🔗 公開ページ

👉 [Star-Delta.github.io](https://github.com/Star-Delta/Star-Delta.github.io)  
👉 ツールHTML: `Markdown_Preview.html`

---

## 主な機能

- 📁 フォルダ単位でローカルMarkdownファイルを読み込み
- 📑 セレクトボックスで複数Markdownファイルを切り替え
- 🔄 ファイル更新を1秒ごとに検出して自動反映
- 🖼 Markdown中の相対パス画像をローカルから表示
- 🧠 Mermaid.js コードブロック描画に対応
- 🔗 外部リンクは新しいタブで開き、`rel="noopener noreferrer"` を自動追加
- ℹ️ 情報ボタンで README / LICENSE を画面上に表示（モーダル）
- 🌙 ダーク／ライトモード自動切替に対応
- 🖨 印刷時にUIボタンを非表示

---

## ❗ 現時点の制限事項・既知の非対応

- 🔗 **ページ内リンク（`[見出し](#見出し名)`）は未対応です**  
  → Markdown見出しに自動で `id` を付ける機能が未実装のため、ジャンプ不可
- 🔒 すべてのリンクが新しいタブで開きます  
  → 内部ファイルリンクやページ内アンカーを除外する機能は未実装

---

## 使用方法

1. ブラウザで `Markdown_Preview.html` を開く
2. 「📁 フォルダ選択」ボタンをクリック
3. `.md` ファイルが含まれたローカルフォルダを選択
4. 最初の `.md` ファイルが自動表示され、選択リストから他のファイルも切替可能
5. Mermaid記法が含まれている場合、自動描画されます

---

## ✅ 完全ローカルでの実行方法

このツールは**インターネット接続不要・完全ローカルでの実行**が可能です。

### 手順：

1. 以下のファイルを同じフォルダに保存  
   - `Markdown_Preview.html`
   - `marked.min.js`
   - `mermaid.min.js`
   - `Markdown.css`（オプション）

2. HTML内の `<script>` や `<link>` タグのCDNリンクを相対パスに変更する  
   例：

   ```html
   <script src="./marked.min.js"></script>
   <script src="./mermaid.min.js"></script>
   <link rel="stylesheet" href="./Markdown.css">
   ```

3. `Markdown_Preview.html` をローカルで直接開く（`file:///〜`）

> 📌 事前にブラウザが **File System Access API** に対応している必要があります（Chrome/Edge推奨）

---

## 使用技術

| 項目        | 内容 |
|-------------|------|
| HTML/CSS    | スタンドアロンなフロントエンド実装 |
| JavaScript  | Vanilla JS（依存なし） |
| Markdown変換 | [`marked.js`](https://marked.js.org/) |
| Mermaid描画 | [`mermaid.js`](https://mermaid.js.org/) |
| 外部スタイル | [Star-Delta/Markdown.css](https://star-delta.github.io/CSS/Markdown.css) |

---

## 想定ディレクトリ構成

```
📁 任意のフォルダ/
├─ doc1.md
├─ flowchart.md      ← Mermaid含むMarkdown
├─ image.png
├─ Markdown_Preview.html
├─ marked.min.js
├─ mermaid.min.js
└─ Markdown.css (任意)
```

---

## ライセンス

このプロジェクトは [MITライセンス](./LICENSE) の下で提供されています。  
自由にご利用・改変・再配布可能ですが、著作権表記とライセンス文の保持が必要です。

---

## 作者

- 開発者：[Star-Delta](https://github.com/Star-Delta)
