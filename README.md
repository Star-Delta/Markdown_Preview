# Markdown_Preview

Webブラウザ上でローカルのMarkdownファイル（`.md`、`.markdown`）をプレビューするツールです。  
Markdownドキュメントを表示したいけどプレビュー用ソフトウェアのインストールすら許可されない環境を想定して作成しています。  
当ツールにMarkdownファイルの編集機能は搭載しておりません、Markdownファイルを編集する際は別途テキストエディタなどをご利用ください。

## 🔗 リポジトリ

👉 [Markdown_Preview](https://github.com/Star-Delta/Markdown_Preview)  

---

## 主な機能
- 📁 選択したフォルダとサブフォルダ内のMarkdownファイルを読み込み
- 📑 セレクトボックスで複数Markdownファイルを切り替え
- 🔄 ファイル更新を1秒ごとに検出して自動反映
- 🛡 DOMPurifyにより、Markdown内のHTMLから危険な要素・属性・URLを除去
  - 🔒 `style`、`template`、SVG、MathMLや危険な属性・URLなどは表示に反映されません。
- 🧠 Mermaid.js コードブロック描画に対応
- 📐 KaTeXによるインライン数式・ブロック数式の描画に対応
- 🌙 OSやブラウザの設定に応じたダークモード表示
- 🖨 Markdown用の印刷スタイルを適用し、操作欄を自動的に非表示

---

## 使用ライブラリ

| ライブラリ名                                               | 利用Version | 用途                                     |
| ---------------------------------------------------------- | ----------- | ---------------------------------------- |
| [Marked](https://marked.js.org/)                           | 18.0.7      | MarkdownをHTMLへ変換                     |
| [DOMPurify](https://github.com/cure53/DOMPurify)           | 3.4.14      | Markdownから生成したHTMLをサニタイズ     |
| [Mermaid](https://mermaid.js.org/)                         | 11.16.0     | Mermaidコードブロックを図として描画      |
| [KaTeX](https://katex.org/)                                | 0.16.0      | インライン数式・ブロック数式を描画       |
| [Markdown-CSS](https://github.com/Star-Delta/Markdown-CSS) | 0           | Markdownの画面表示・印刷用スタイルを適用 |

---

## 動作環境

- デスクトップ版のGoogle ChromeまたはMicrosoft Edgeの最新版を推奨します。
- フォルダの選択と読み込みに[File System Access API（`showDirectoryPicker`）](https://developer.mozilla.org/ja/docs/Web/API/Window/showDirectoryPicker)を使用します。このAPIはChrome 86およびEdge 86以降で利用できますが、本ツール全体としてこれらのバージョンまでの動作を保証するものではありません。
- FirefoxおよびSafariは、必要な`showDirectoryPicker`に対応していないため対象外です。その他のChromium系ブラウザでも動作する可能性がありますが、動作確認は行っていません。
- `Markdown_Preview.html`をローカルファイルとして直接開いて使用します。ブラウザや端末のセキュリティ設定、組織の管理ポリシーなどにより、JavaScriptの実行やローカルフォルダの読み込みが制限される場合があります。
- 外部ライブラリとスタイルシートをCDNから読み込むため、インターネット接続が必要です。
- フォルダの読み込み時にブラウザの許可が必要です。本ツールは選択されたフォルダ内のファイルを読み取りますが、ファイルの書き込みは行いません。

---

## ❗ 現時点の制限事項・既知の非対応
- 🖼 Markdown記法（`![代替テキスト](画像パス)`）によるローカル画像表示は試験的な対応です。HTMLの`<img>`によるローカル画像指定は相対パス解決の対象外であり、正しく表示されない場合があります。
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
