# Markdown_Preview

Webブラウザ上でローカルのMarkdownファイル（`.md`）をプレビューするツールです。  
AIを利用したコーディングの検証を兼ねて個人用に作成したものなので、粗が目立つ点についてはご了承ください。  

## 🔗 公開ページ

👉 [Markdown_Preview](https://github.com/Star-Delta/Markdown_Preview)  

---

## 主な機能

- 📁 フォルダ単位でローカルMarkdownファイルを読み込み
- 📑 セレクトボックスで複数Markdownファイルを切り替え
- 🔄 ファイル更新を1秒ごとに検出して自動反映
- 🧠 Mermaid.js コードブロック描画に対応
- 🌙 ダーク／ライトモード自動切替に対応
- 🖨 印刷時にUIボタンを非表示

---

## ❗ 現時点の制限事項・既知の非対応
- 📌 事前にブラウザが **File System Access API** に対応している必要があります（Chrome/Edge推奨）  
- 💡 セキュリティ制限により、環境によってはローカルファイルからのJavaScript実行に制限がある場合があります。
- 🖼 相対パスで指定された画像は、選択したフォルダ(およびサブフォルダ)以外のフォルダに保管されている画像は表示できません。
- 🔗現状、リンク周りの動作が怪しいです。
  -  ページ内リンク（`[見出し](#見出し名)`）は未対応です  
  -  すべてのリンクが新しいタブで開きます  

---

## 使用方法

1. 当リポジトリをZIPでダウンロード
2. ブラウザで `Markdown_Preview.html` を開く
3. 「📁 フォルダ選択」ボタンをクリック
4. `.md` ファイルが含まれたローカルフォルダを選択

### ✅ 完全ローカルでの実行方法
1. 以下のファイルを同じフォルダに保存  
   ```plaintext
   Markdown_Preview-main/
   ├ LICENSE
   ├ Markdown_Preview.html
   ├ README.md
   ├ marked.min.js              ← CDNからダウンロード
   ├ mermaid.min.js             ← CDNからダウンロード
   └ github-markdown.css        ← CDNからダウンロード
   ```
2. HTML内の `<script>` や `<link>` タグのCDNリンクを相対パスに変更する  
   例：
   ```html
   <script src="./marked.min.js"></script>
   <script src="./mermaid.min.js"></script>
   <link rel="stylesheet" href="./github-markdown.css">
   ```
3. `Markdown_Preview.html` をWebブラウザで開く
4. 「📁 フォルダ選択」から `Markdown_Preview.html` を保管しているフォルダを選択
5. `README.md`が問題なく表示されることを確認
   ```mermaid
   graph TD;
     mermaidjs動作チェック;
     図形が表示されたらOK;
   ```

---

## 使用技術

| 項目         | 内容                                                                   |
| ------------ | ---------------------------------------------------------------------- |
| Markdown変換 | [`marked.js`](https://marked.js.org/)                                  |
| Mermaid描画  | [`mermaid.js`](https://mermaid.js.org/)                                |
| 外部スタイル | [`github-markdown.css`](https://sindresorhus.com/github-markdown-css/) |

---

## ライセンス

このプロジェクトは [MITライセンス](./LICENSE) の下で提供されています。  
自由にご利用・改変・再配布可能ですが、著作権表記とライセンス文の保持が必要です。

---

## 作者

- 開発者：[Star-Delta](https://github.com/Star-Delta)
