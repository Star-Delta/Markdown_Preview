# Markdown_Preview
## 目次
1. [目次](#目次)
2. [概要](#概要)
   1. [主な機能](#主な機能)
   2. [動作環境](#動作環境)
3. [使用方法](#使用方法)
4. [使用ライブラリ](#使用ライブラリ)
   1. [Highlight.js](#highlightjs)
5. [ライセンス](#ライセンス)
6. [作者](#作者)

## 概要
Webブラウザ上でローカルのMarkdownファイル（`.md`、`.markdown`）をプレビューするツールです。  
当ツールにMarkdownファイルの編集機能は搭載しておりません、Markdownファイルを編集する際は別途テキストエディタなどをご用意ください。

### 主な機能
- 📁 選択したフォルダとサブフォルダ内のMarkdownファイルを読み込み
- 📑 セレクトボックスで複数Markdownファイルを切り替え
- 🔄 ファイル更新を1秒ごとに検出して自動反映
- 🛡 DOMPurifyにより、Markdown内のHTMLから危険な要素・属性・URLを除去
  - 🔒 `style`、`template`、SVG、MathMLや危険な属性・URLなどは表示に反映されません。
- 🧠 Mermaid.js コードブロック描画に対応
- 🎨 言語を指定したコードブロックをHighlight.jsで色分け（ライト・ダーク表示に追従し、印刷はライト配色）
- 📐 KaTeXによるインライン数式・ブロック数式の描画に対応
- 🌙 OSやブラウザの設定に応じたダークモード表示
- 🖨 Markdown用の印刷スタイルを適用し、操作欄を自動的に非表示

> [!Warning]
> **現時点の制限事項・既知の非対応**
> - 🖼 Markdown記法（`![代替テキスト](画像パス)`）によるローカル画像表示は試験的な対応です。HTMLの`<img>`によるローカル画像指定は相対パス解決の対象外であり、正しく表示されない場合があります。
> - 🔗アンカーリンクに対応していません。

### 動作環境
- デスクトップ版のGoogle ChromeまたはMicrosoft Edgeの最新版を推奨します。
- フォルダの選択と読み込みに[File System Access API（`showDirectoryPicker`）](https://developer.mozilla.org/ja/docs/Web/API/Window/showDirectoryPicker)を使用します。このAPIはChrome 86およびEdge 86以降で利用できますが、本ツール全体としてこれらのバージョンまでの動作を保証するものではありません。
- FirefoxおよびSafariは、必要な`showDirectoryPicker`に対応していないため対象外です。その他のChromium系ブラウザでも動作する可能性がありますが、動作確認は行っていません。
- `Markdown_Preview.html`をローカルファイルとして直接開いて使用します。ブラウザや端末のセキュリティ設定、組織の管理ポリシーなどにより、JavaScriptの実行やローカルフォルダの読み込みが制限される場合があります。
- 外部ライブラリとスタイルシートをCDNから読み込むため、インターネット接続が必要です。
- フォルダの読み込み時にブラウザの許可が必要です。本ツールは選択されたフォルダ内のファイルを読み取りますが、ファイルの書き込みは行いません。

## 使用方法

1. [GitHub](https://github.com/Star-Delta/Markdown_Preview/tags)から最新のバージョンをダウンロード
2. ブラウザで `Markdown_Preview.html` を開く
3. 「📁 フォルダ選択」ボタンをクリック
4. `.md` または `.markdown` ファイルが含まれたローカルフォルダを選択

## 使用ライブラリ

| ライブラリ名                                               | 利用Version   | 用途                                       |
| ---------------------------------------------------------- | ------------- | ------------------------------------------ |
| [Marked](https://marked.js.org/)                           | 18.0.7        | MarkdownをHTMLへ変換                       |
| [DOMPurify](https://github.com/cure53/DOMPurify)           | 3.4.14        | Markdownから生成したHTMLをサニタイズ       |
| [Highlight.js](https://highlightjs.org/)                   | 本体: 11.11.1 | 言語指定付きコードブロックの構文ハイライト |
| [Mermaid](https://mermaid.js.org/)                         | 11.16.0       | Mermaidコードブロックを図として描画        |
| [KaTeX](https://katex.org/)                                | 0.16.0        | インライン数式・ブロック数式を描画         |
| [Markdown-CSS](https://github.com/Star-Delta/Markdown-CSS) | 0             | Markdownの画面表示・印刷用スタイルを適用   |

### Highlight.js

本ツールが使用しているライブラリと対応する言語は以下の通りです、言語とエイリアスの一覧は[公式の対応言語一覧（11.11.1）](https://github.com/highlightjs/highlight.js/blob/11.11.1/SUPPORTED_LANGUAGES.md)を参照してください。

|ライブラリ|言語|
|-|-|
|`highlight.min.js`|`bash`, `c`, `cpp`, `csharp`, `css`, `diff`, `go`, `graphql`, `ini`, `java`, `javascript`, `json`, `kotlin`, `less`, `lua`, `makefile`, `markdown`, `objectivec`, `perl`, `php`, `php-template`, `plaintext`, `python`, `python-repl`, `r`, `ruby`, `rust`, `scss`, `shell`, `sql`, `swift`, `typescript`, `vbnet`, `wasm`, `xml`, `yaml`|
|`powershell.min.js`|`powershell`|
|`dos.min.js`|`dos`|

- 言語の自動判定は行いません。言語指定なし・未対応言語・`text`・`txt`・`plaintext`・`nohighlight`・`no-highlight`は通常のコード表示になります。
- HTMLで直接記述した`<pre><code class="language-****">…</code></pre>`も対象ですが、`code`内にHTMLの子要素がある場合や、`nohighlight`・`no-highlight`クラスを持つ領域は処理しません。

## ライセンス

このプロジェクトは [Mozilla Public License 2.0](./LICENSE) の下で提供されています。

## 作者

- 開発者：[Star-Delta](https://github.com/Star-Delta)
