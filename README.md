# Markdown_Preview

Webブラウザ上でローカルのMarkdownファイル（`.md`、`.markdown`）をプレビューするツールです。  
AIを利用したコーディングの検証を兼ねて個人用に作成したものなので、粗が目立つ点についてはご了承ください。  

## 🔗 リポジトリ

👉 [Markdown_Preview](https://github.com/Star-Delta/Markdown_Preview)  

---

## 主な機能
- 📁 選択したフォルダとサブフォルダ内のMarkdownファイルを読み込み
- 📑 セレクトボックスで複数Markdownファイルを切り替え
- 🔄 ファイル更新を1秒ごとに検出して自動反映
- 🛡 DOMPurifyにより、Markdown内のHTMLから危険な要素・属性・URLを除去
- 🧠 Mermaid.js コードブロック描画に対応
- 📐 KaTeXによるインライン数式・ブロック数式の描画に対応
- 🌙 OSやブラウザの設定に応じたダークモード表示
- 🖨 Markdown用の印刷スタイルを適用し、操作欄を自動的に非表示

---

## ❗ 現時点の制限事項・既知の非対応
- 🔒 Markdown内のHTMLは安全性を優先して処理するため、`style`、`template`、SVG、MathMLや危険な属性・URLなどは表示に反映されません。
- 📌 事前にブラウザが File System Access API に対応している必要があります（Chrome/Edge推奨）  
- 💡 セキュリティ制限により、環境によってはローカルファイルからのJavaScript実行に制限がある場合があります。
- 🌐 外部ライブラリをCDNから読み込むため、利用時にはインターネット接続が必要です。
- 🌐 外部画像は表示時に参照先へ接続します。
- 🖼 Markdown内の画像表示は試験的な対応であり、ファイルの配置や指定方法によっては正しく表示されない場合があります。
- 🔗アンカーリンクに対応していません。

---

## 使用方法

1. 当リポジトリをZIPでダウンロード
2. ブラウザで `Markdown_Preview.html` を開く
3. 「📁 フォルダ選択」ボタンをクリック
4. `.md` または `.markdown` ファイルが含まれたローカルフォルダを選択

## ライセンス

このプロジェクトは [Mozilla Public License 2.0](./LICENSE) の下で提供されています。

---

## 作者

- 開発者：[Star-Delta](https://github.com/Star-Delta)
