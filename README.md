# Markdown_Preview
## 目次
1. [目次](#目次)
2. [概要](#概要)
   1. [主な機能](#主な機能)
   2. [動作環境](#動作環境)
3. [使用方法](#使用方法)
   1. [基本操作](#基本操作)
4. [使用ライブラリ](#使用ライブラリ)
   1. [Marked](#marked)
   2. [DOMPurify](#dompurify)
   3. [Highlight.js](#highlightjs)
   4. [Mermaid](#mermaid)
   5. [KaTeX](#katex)
   6. [Markdown-CSS](#markdown-css)
5. [ライセンス](#ライセンス)
6. [作者](#作者)

## 概要
Webブラウザ上でローカルのMarkdownファイル（`.md`、`.markdown`）をプレビューするツールです。  
当ツールにMarkdownファイルの編集機能は搭載しておりません、Markdownファイルを編集する際は別途テキストエディタなどをご用意ください。

### 主な機能
- 📁 選択したフォルダとサブフォルダ内のMarkdownファイルを読み込み
- 📑 セレクトボックスで複数Markdownファイルを切り替え
- 🔄 ファイル更新を1秒ごとに検出して自動反映
- 🌙 OSやブラウザの設定に応じたダークモード表示
- 🖨 Markdown用の印刷スタイルを適用し、操作欄を自動的に非表示
- 🛡 DOMPurifyにより、Markdown内のHTMLから危険な要素・属性・URLを除去
- 🧠 Mermaid.js コードブロック描画に対応
- 🎨 言語を指定したコードブロックをHighlight.jsで色分け（ライト・ダーク表示に追従し、印刷はライト配色）
- 📐 KaTeXによるインライン数式・ブロック数式の描画に対応

> [!Warning]
> **現時点の制限事項・既知の非対応**
> - 🖼 ローカル画像は選択フォルダ内のファイルが対象です。見つからない画像は、代替テキストと「画像が見つかりません」を表示します。
> - 🖼 `srcset`による画像候補の切り替えには対応していません。`<picture>`も`<img src="…">`のみで表示します。
> - 🎞 HTMLの`video`・`audio`によるローカル動画・音声に対応します。再生できる形式はブラウザに依存します。字幕の`track`やリンク先などは、ローカル参照の解決対象外です。
> - 🔗アンカーリンクに対応していません。
> - 🔗 `[別の文書](other.md)`などの相対リンクによる、選択フォルダ内の文書への移動には対応していません。Web版では公開ページのURLを基準に解決されるため、意図しないページへの移動や404になる場合があります。別のMarkdownファイルは画面上部のセレクトボックスから選択してください。

Markdownの変換・描画はブラウザ内で行い、本ツールにはMarkdown本文や選択フォルダ内のファイルをサーバーへアップロードする処理はありません。  

### 動作環境
#### 【必須】File System Access API（`showDirectoryPicker`）
フォルダの選択と読み込みに[File System Access API（`showDirectoryPicker`）](https://developer.mozilla.org/ja/docs/Web/API/Window/showDirectoryPicker)を使用します。  
対応しているブラウザについては[こちら](https://developer.mozilla.org/ja/docs/Web/API/Window/showDirectoryPicker)からご確認ください。  
尚、本ツールは選択されたフォルダ内のファイルを読み取りますが、ファイルの書き込みは行いません。  

当ツールの動作確認はデスクトップ版Chromeにて実施しております。  
その他のブラウザの動作については保証いたしません。

## 使用方法
Web版とDownload版があり、どちらも機能に差はありません。

| 使用方法   | URL                                                                | 準備                                                                                                  |
| ---------- | ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| Web版      | [Markdown_Preview](https://star-delta.github.io/Markdown_Preview/) | リンク先ににアクセスするだけで使用できます。                                                          |
| Download版 | [GitHub](https://github.com/Star-Delta/Markdown_Preview/tags)      | リンク先から最新のバージョンをダウンロードし、Webブラウザで`Markdown_Preview.html` を開いてください。 |

### 基本操作
1. 「📁 フォルダ選択」ボタンをクリック
2. `.md` または `.markdown` ファイルが含まれたローカルフォルダを選択

## 使用ライブラリ

| ライブラリ名                                               | 利用Version | 用途                                       |
| ---------------------------------------------------------- | ----------- | ------------------------------------------ |
| [Marked](https://marked.js.org/)                           | 18.0.7      | MarkdownをHTMLへ変換                       |
| [DOMPurify](https://github.com/cure53/DOMPurify)           | 3.4.14      | Markdownから生成したHTMLをサニタイズ       |
| [Highlight.js](https://highlightjs.org/)                   | 11.11.1     | 言語指定付きコードブロックの構文ハイライト |
| [Mermaid](https://mermaid.js.org/)                         | 11.16.0     | Mermaidコードブロックを図として描画        |
| [KaTeX](https://katex.org/)                                | 0.18.7      | インライン数式・ブロック数式を描画         |
| [Markdown-CSS](https://github.com/Star-Delta/Markdown-CSS) | 0           | Markdownの画面表示・印刷用スタイルを適用   |

### Marked

MarkdownをHTMLへ変換します。コードブロックの変換をMermaid用に拡張し、画像・動画・音声の参照はHTML生成・サニタイズ後に処理します。

- Markdown記法（リスト・表の内部を含む）とHTMLの`<img src="…">`によるローカル画像は、表示中のMarkdownファイルの位置を基準に解決します。先頭が`/`のパスは選択フォルダを基準とし、選択フォルダより上の階層は参照できません。
- Web版・Download版とも、解決できない画像参照は表示前に除去し、代替テキストと「画像が見つかりません」を表示します。ツールのHTMLの保存場所や公開URLを基準とした再読み込みは行いません。代替テキストがなければメッセージのみを表示します。
- HTMLの`video src`・`audio src`、それらの直下にある`source src`、`video poster`も同じ起点で解決します。未解決の属性や候補は表示前に除去し、プレーヤーの隣に参照先が見つからない旨を表示します。ほかの有効な候補は残します。
- 明示的な外部画像・動画・音声のURLは引き続き利用できます。外部リソースの読み込み時には配信元への通信が発生します。
- 言語指定が`mermaid`のコードブロックは、通常のコード表示ではなくMermaid用の要素へ変換します。それ以外のコードブロックはMarkedの標準処理に任せます。
- 生成したHTMLは、そのまま表示せずDOMPurifyでサニタイズします。ローカル画像・動画・音声はサニタイズ後に、ツールが生成したBlob URLを設定して表示します。
- 表示後のリンクには`target="_blank"`と`rel="noopener noreferrer"`を設定します。

### DOMPurify
Markdownに直接記載されたHTMLタグとそれらに指定された属性のうち、以下に記載するものは描画時に削除されます。

| HTML | 削除対象                                                                                                          |
| ---- | ----------------------------------------------------------------------------------------------------------------- |
| タグ | `style`, `template`, `form`, `button`, `select`, `textarea`, [tags.ts](https://github.com/cure53/DOMPurify/blob/3.4.14/src/tags.ts)に記載されていないもの |
| 属性 | `style`, `srcset`, [attrs.ts](https://github.com/cure53/DOMPurify/blob/3.4.14/src/attrs.ts)に記載されていないもの           |

Markedが生成したHTMLから危険な要素・属性・URLを除去してから、プレビューへ挿入します。[公式の設定説明](https://github.com/cure53/DOMPurify#can-i-configure-dompurify)に基づき、次の設定を適用しています。

| 設定                   | 本ツールでの指定        | 表示への影響                                                                      |
| ---------------------- | ----------------------- | --------------------------------------------------------------------------------- |
| `USE_PROFILES`         | `{ html: true }`        | Markdown内に直接記述されたSVG・MathMLは許可せず、HTML用の許可リストを使用します。 |
| `FORBID_TAGS`          | `['style', 'template', 'form', 'button', 'select', 'textarea']` | スタイル定義・テンプレート要素と、フォーム・ボタン・選択欄・テキスト入力欄のタグを除去します。 |
| `FORBID_ATTR`          | `['style', 'srcset']`   | インラインスタイルと画像候補の指定を除去します。                                      |
| `SANITIZE_NAMED_PROPS` | `true`                  | `id`・`name`に`user-content-`接頭辞を付け、ツール側のDOM参照との衝突を防ぎます。  |

`srcset`はローカル・外部画像を問わず除去します。`<picture>`内の`<source srcset="…">`による候補指定も無効となり、`<img src="…">`のみを使用します。

`input`の制限は追加していないため、Markdownのタスクリスト用チェックボックスは維持されます。除去するタグ内のテキストなどは、DOMPurifyの規則に従って残る場合があります。

構文ハイライト・数式・Mermaid図はサニタイズ後に各ライブラリで生成します。Markdownに直接書いたSVG・MathMLの制限は、これらの描画結果を禁止するものではありません。

### Highlight.js

言語を指定したコードブロックを色分けします。本ツールが読み込むファイルと対応言語は以下のとおりです。すべて11.11.1を使用しており、言語名とエイリアスは[公式の対応言語一覧（11.11.1）](https://github.com/highlightjs/highlight.js/blob/11.11.1/SUPPORTED_LANGUAGES.md)を参照してください。公式一覧には、本ツールが読み込んでいない言語も掲載されています。

| ライブラリ          | 言語                                                                                                                                                                                                                                                                                                                                      |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `highlight.min.js`  | `bash`, `c`, `cpp`, `csharp`, `css`, `diff`, `go`, `graphql`, `ini`, `java`, `javascript`, `json`, `kotlin`, `less`, `lua`, `makefile`, `markdown`, `objectivec`, `perl`, `php`, `php-template`, `plaintext`, `python`, `python-repl`, `r`, `ruby`, `rust`, `scss`, `shell`, `sql`, `swift`, `typescript`, `vbnet`, `wasm`, `xml`, `yaml` |
| `powershell.min.js` | `powershell`                                                                                                                                                                                                                                                                                                                              |
| `dos.min.js`        | `dos`                                                                                                                                                                                                                                                                                                                                     |

- 言語の自動判定は行いません。言語指定なし・未対応言語・`text`・`txt`・`plaintext`・`nohighlight`・`no-highlight`は通常のコード表示になります。
- HTMLで直接記述した`<pre><code class="language-****">…</code></pre>`も対象ですが、`code`内にHTMLの子要素がある場合や、`nohighlight`・`no-highlight`クラスを持つ領域は処理しません。

- ライト表示にはGitHub、ダーク表示にはmonokaiテーマを適用し、印刷には常にライト用テーマを使います。
- テーマ側の背景・余白・スクロール指定を調整し、コードブロックのレイアウトはMarkdown-CSSに任せます。
- ライブラリの読み込みに失敗した場合は通常表示を維持し、個別ブロックの処理で例外が発生した場合は元のコードへ戻して後続の描画を続けます。

### Mermaid

言語を`mermaid`と指定したコードブロックを図として描画します。

- セキュリティの観点から、描画された図内のクリック操作を無効にしています。
- テーマはページを開いた時点の画面設定に応じて、ライト時は`default`、ダーク時は`dark`に設定します。開いた後の配色設定変更には自動追従しません。

### KaTeX

自動レンダリング拡張で、プレビュー内の数式を描画します。MarkdownからHTMLへの変換後に、次の区切りを認識する設定です。

| 表示形式       | 区切り                   |
| -------------- | ------------------------ |
| インライン数式 | `$ ... $`、`\( ... \)`   |
| ブロック数式   | `$$ ... $$`、`\[ ... \]` |

- Markdown本文でバックスラッシュ付きの区切りを使う場合は、Markedによるエスケープ処理を考慮して`\\( ... \\)`・`\\[ ... \\]`と記述します。通常は`$`・`$$`での指定が簡単です。
- コードブロックとインラインコードの内部は、自動レンダリング拡張の標準設定により数式変換の対象外です。[公式の自動レンダリング説明](https://katex.org/docs/autorender.html)
- `trust: false`で外部リソースの読み込みやHTML属性の操作などを行う信頼が必要なコマンドを許可せず、`throwOnError: false`で数式の構文エラーによる例外を抑えます。不正な数式はエラー色で表示されます。[公式のオプション説明](https://katex.org/docs/options.html)

### Markdown-CSS

Markdown本文の見出し・表・引用・コードなどの表示と印刷用スタイルを適用します。

- `Markdown.css`を通常のスタイルシートとして、`Markdown_Print.css`を`media="print"`付きで読み込みます。
- プレビューには`markdown-body`、ページ全体の配色には`markdown-colorpallet`クラスを指定しています。
- フォルダ選択などの操作欄と情報モーダルは、本ツールのHTML内にあるCSSでレイアウトを定義しています。`Hidden_when_printing`クラスを付けた操作欄・モーダルは印刷時に非表示にします。
- CDNの`@0`を参照しています。個別のリリース番号への固定ではないため、配信されるCSSが更新される場合があります。

## ライセンス

このプロジェクトは [Mozilla Public License 2.0](./LICENSE) の下で提供されています。

## 作者

- 開発者：[Star-Delta](https://github.com/Star-Delta)
