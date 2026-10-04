# Markdown_Preview

1. [概要](#概要)
   1. [主な機能](#主な機能)
   2. [動作環境](#動作環境)
   3. [制限事項・注意事項](#制限事項注意事項)
2. [使用方法](#使用方法)
   1. [基本操作](#基本操作)
   2. [編集と再読み込み](#編集と再読み込み)
   3. [印刷](#印刷)
   4. [ツール情報](#ツール情報)
3. [対応する記法と表示方法](#対応する記法と表示方法)
   1. [アラート](#アラート)
   2. [Mermaid図](#mermaid図)
   3. [数式](#数式)
   4. [HTMLによる記述](#htmlによる記述)
4. [使用ライブラリ](#使用ライブラリ)
5. [ライセンス](#ライセンス)
6. [作者](#作者)

## 概要

Webブラウザ上でローカルのMarkdownファイル（`.md`、`.markdown`）をプレビューするツールです。

> [!IMPORTANT]
> 当ツールにMarkdownファイルの編集機能はありません。  
> Markdownファイルを編集する場合は、別途テキストエディタなどを使用してください。

### 主な機能


- Markdownの変換と表示はブラウザ内で行い、選択したフォルダ内のファイルをサーバーへアップロードしない
- 📁 選択したフォルダとサブフォルダ内のMarkdownファイルを読み込み
- 📑 画面上部のファイル選択欄で表示するMarkdownファイルを切り替え
- 🔄 表示中のMarkdownファイルの更新を1秒ごとに確認し、保存された変更を自動反映
- 🖨 Markdown用の印刷スタイルを適用し、操作欄を印刷時に非表示
- 🌙 OSやブラウザの設定に応じたダークモード表示
- 🎨 言語を指定したコードブロックを色分け
- ⚠️ アラート記法に対応し、絵文字・種類名・色付き罫線を表示
- 🧠 Mermaid記法で記述した図を表示
- 📐 インライン数式・ブロック数式を表示

### 動作環境

動作確認はデスクトップ版Chromeで実施しています。その他のブラウザでの動作は保証していません。

ローカルフォルダを選択して読み取れるブラウザが必要です。[フォルダ選択機能の対応ブラウザ](https://developer.mozilla.org/ja/docs/Web/API/Window/showDirectoryPicker)も確認してください。

Web版・Download版ともに、起動時の外部読み込みにインターネット接続が必要です。Download版も、オフラインでの利用を前提とした配布ではありません。

### 制限事項・注意事項
#### リンク

プレビュー本文内のリンクは、別タブで開きます。

- 文書内の見出しなどへのアンカーリンクによる移動には対応していません。
- `[別の文書](other.md)`などの相対リンクによる、選択フォルダ内の文書への移動には対応していません。
- 相対リンクは、表示中のMarkdownファイルの位置ではなく、本ツールを開いた場所を基準に扱われます。Web版では公開ページのURL、Download版では`Markdown_Preview.html`の保存場所が基準となり、意図しないページへの移動や読み込み失敗が起こる場合があります。

別のMarkdownファイルを表示する場合は、画面上部のファイル選択欄から選んでください。

#### 外部への通信
> [!WARNING]
> 通信先の安全性については確認しないため、信頼できない入手元から入手したMarkdownファイルを表示する際はご注意ください。

Web版・Download版ともに、次の通信が発生します。
- 起動時に、表示に必要なプログラムやスタイルを外部の配信元から読み込みます。読み込みに失敗すると、表示や操作が正常に動作しない場合があります。
- 文書内で外部画像・動画・音声などのURLを指定した場合、読み込み時に配信元へ通信します。

## 使用方法

| 使用方法   | 入手先                                                                  | 開き方                                                                            |
| ---------- | ----------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| Web版      | [Markdown_Preview](https://star-delta.github.io/Markdown_Preview/)      | ブラウザで公開ページにアクセスします。                                            |
| Download版 | [GitHubのタグ一覧](https://github.com/Star-Delta/Markdown_Preview/tags) | 使用するバージョンをダウンロードし、ブラウザで`Markdown_Preview.html`を開きます。 |

### 基本操作

1. 「📁 フォルダ選択」ボタンをクリックします。
2. `.md`または`.markdown`ファイルが含まれたローカルフォルダを選択します。ブラウザが読み取りの許可を求めた場合は許可してください。
3. 読み込み後、一覧の先頭にあるMarkdownファイルが表示されます。別のファイルを表示する場合は、画面上部のファイル選択欄から選びます。

サブフォルダ内のMarkdownファイルも選択できます。別のフォルダへ切り替える場合は、再度フォルダ選択ボタンをクリックしてください。

#### フォルダの選び方

Markdownファイルと、そこから参照するローカル画像・動画・音声が、すべて選択フォルダ内に含まれるように選んでください。

例えば、次の配置では`project`フォルダを選択します。

```text
project/
├── docs/
│   └── readme.md
└── images/
    └── sample.png
```

`docs/readme.md`には、次のように画像を記述できます。

```markdown
![サンプル画像](../images/sample.png)
```

`docs`フォルダだけを選択すると、選択フォルダの外にある`images/sample.png`は表示できません。

### 編集と再読み込み

表示中のMarkdownファイルを別のエディタで編集し、保存すると、変更を自動反映します。未保存の変更は反映されません。

自動更新の対象は、表示中のMarkdownファイルです。画像・動画・音声の差し替えや、ファイルの追加・名前変更を反映する場合は、フォルダを選択し直してください。

### 印刷

印刷するMarkdownファイルを表示し、ブラウザの印刷機能を使用してください。

操作欄とツール情報のウィンドウは印刷されません。本文、アラート、コードの色分けにはライト用の配色を使用します。

### ツール情報

画面上部の「ℹ️」をクリックすると、ツール情報と、使い方・ライセンスへのリンクを表示します。

「×」またはウィンドウの外側の背景部分をクリックすると閉じます。

## 対応する記法と表示方法
CommonMarkとGFMの記法を基本とし、以下の拡張記法に対応しています。  
HTMLの表示制限やリンクの動作などには、本ツール独自の制限があります。  

コードブロックに指定された以下の言語は色分けされます。
```text
bash, c, cpp, csharp, css, diff, dos, go, graphql, ini, java,
javascript, json, kotlin, less, lua, makefile, markdown,
objectivec, perl, php, php-template, powershell, python,
python-repl, r, ruby, rust, scss, shell, sql, swift,
typescript, vbnet, wasm, xml, yaml
```
> [!TIP]
> `nohighlight`・`no-highlight`クラスを付けた領域は色分けしません。

言語名の別名は[対応言語・別名の一覧](https://github.com/highlightjs/highlight.js/blob/11.11.1/SUPPORTED_LANGUAGES.md)を参照してください。リンク先には、本ツールが対応していない言語も掲載されています。

- 言語の自動判定は行いません。言語指定なし・未対応言語・`text`・`txt`・`plaintext`・`nohighlight`・`no-highlight`は、色分けしない通常のコード表示になります。
- 色分けはライト・ダーク表示に追従し、印刷にはライト配色を使用します。

本文・アラート・コードの色分けは、OSやブラウザのライト・ダーク表示に追従し、印刷にはライト配色を使用します。
> [!WARNING]
> mermaidにて作成された図は、開いた後の配色設定変更には自動追従しません。  
> 変更後の配色で図を表示する場合は、ページを開き直し、フォルダを再選択してください。

### アラート
引用の先頭にアラートの種類を記述すると、絵文字と種類名を付けて表示します。

```markdown
> [!WARNING]
> 注意事項をここに記述します。
```

| マーカー       | 絵文字 | 種類名    |
| -------------- | ------ | --------- |
| `[!NOTE]`      | ℹ️      | Note      |
| `[!TIP]`       | 💡      | Tip       |
| `[!IMPORTANT]` | ❗      | Important |
| `[!WARNING]`   | ⚠️      | Warning   |
| `[!CAUTION]`   | 🛑      | Caution   |

- マーカーは大文字で指定してください。`[!Warning]`・`[!warning]`や未対応の種類は、通常の引用として表示します。
- 本文には通常のMarkdown記法を使用できます。複数のアラートを分ける場合は、引用ブロックの間に空行を入れてください。
- 引用内・リスト内のアラートも表示できますが、GitHubと完全に同じ表示仕様ではありません。
- 独自の種類・タイトル・折り畳み記法には対応していません。
- 長いアラートはページをまたいで表示できます。
- 絵文字の見た目はOS・フォントによって異なります。

### Mermaid図

コードブロックの言語に`mermaid`を指定すると、図として表示します。

````markdown
```mermaid
flowchart LR
    A[開始] --> B[終了]
```
````

- 図内のクリック操作には対応していません。

### 数式

インライン数式は`$ ... $`、ブロック数式は`$$ ... $$`で記述できます。

```markdown
インライン数式：$E = mc^2$

$$
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$
```

バックスラッシュ付きの区切りを使用する場合は、Markdown本文ではインライン数式を`\\( ... \\)`、ブロック数式を`\\[ ... \\]`と記述してください。

- コードブロックとインラインコード内の数式は変換しません。
- 不正な数式はエラー色で表示されます。
- 数式から外部リソースを読み込んだり、HTML属性を操作したりする一部のコマンドには対応していません。

### HTMLによる記述
Markdown内に記述したHTMLは、危険な要素・属性・URLや、表示に対応していない指定を除去するため、そのままの表示にならない場合があります。

- 直接記述したSVG・MathML、スタイル定義・インラインスタイル、テンプレート要素には対応していません。
  > [!NOTE]
  > この制限によって、Mermaid記法による図や、数式記法による数式の表示が禁止されることはありません。
- `<form>`・`<button>`・`<select>`・`<textarea>`による表示には対応していません。
  > [!NOTE]  
  > Markdownのタスクリスト用チェックボックスは表示できます。
- 除去したタグ内のテキストは、残る場合があります。

以下では、許可されているHTMLの一例を説明します。

#### 画像
Markdownの画像記法に加え、HTMLの`<img src="…">`を使用できます。リストや表の中の画像も表示できます。

- ローカル画像のパスは、表示中のMarkdownファイルがあるフォルダを基準に記述します。`./`や`../`も使用できます。
- 先頭が`/`のローカルパスは、選択フォルダを基準に扱います。選択フォルダより上の階層は参照できません。
- 見つからないローカル画像は、代替テキストと「画像が見つかりません」を表示します。代替テキストがない場合は、メッセージのみを表示します。
- 外部画像のURLも使用できます。読み込み時の通信については[注意事項](#外部への通信)を確認してください。
- `srcset`による画像候補の切り替えには対応していません。`<picture>`を記述した場合も、`<img src="…">`のみで表示します。

#### 動画・音声
HTMLの`<video>`・`<audio>`を使用できます。再生操作を表示する場合は`controls`を付けてください。

```html
<video controls src="../videos/sample.mp4" poster="../images/poster.png"></video>
<audio controls src="../audio/sample.mp3"></audio>
```

- ローカル動画・音声と、動画のポスター画像のパスは、画像と同じ基準で記述します。
- `<video>`・`<audio>`内に直接記述した`<source src="…">`による再生候補の指定も使用できます。
- ローカルの参照先が見つからない場合は、プレーヤーの隣に説明を表示します。ほかに有効な再生候補がある場合は、その候補を使用できます。
- 再生できる形式はブラウザに依存します。
- 外部動画・音声のURLも使用できます。読み込み時の通信については[注意事項](#外部への通信)を確認してください。
- 字幕の`<track>`による、選択フォルダ内の字幕ファイルの読み込みには対応していません。

#### コードブロック
HTMLの`<pre><code class="language-javascript">…</code></pre>`のような記述は可能で、色分けできます。  
ただし、code内にHTMLの子要素がある場合は色分けしません。
## 使用ライブラリ

ローカルで使用するファイルを取得する際の参考として、現在使用しているライブラリと読み込み先を記載します。

| ライブラリ                                                                           | 使用バージョン・参照指定 | 用途                              | 読み込むファイル                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------------------------------------------------------------------------------------ | ------------------------ | --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Marked](https://marked.js.org/)                                                     | 18.0.7                   | Markdownの変換                    | [marked.umd.js](https://cdn.jsdelivr.net/npm/marked@18.0.7/lib/marked.umd.js)                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [marked-alert](https://github.com/bent10/marked-extensions/tree/main/packages/alert) | 2.1.2                    | アラートの表示                    | [index.umd.js](https://cdn.jsdelivr.net/npm/marked-alert@2.1.2/dist/index.umd.js)                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [DOMPurify](https://github.com/cure53/DOMPurify)                                     | 3.4.14                   | HTMLの危険な要素・属性・URLの除去 | [purify.min.js](https://cdn.jsdelivr.net/npm/dompurify@3.4.14/dist/purify.min.js)                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [Highlight.js](https://highlightjs.org/)                                             | 11.11.1                  | コードの色分け                    | [highlight.min.js](https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.11.1/build/highlight.min.js)、[powershell.min.js](https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.11.1/build/languages/powershell.min.js)、[dos.min.js](https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.11.1/build/languages/dos.min.js)、[github.min.css](https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.11.1/build/styles/github.min.css)、[monokai.min.css](https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.11.1/build/styles/monokai.min.css) |
| [Mermaid](https://mermaid.js.org/)                                                   | 11.16.0                  | 図の表示                          | [mermaid.min.js](https://cdn.jsdelivr.net/npm/mermaid@11.16.0/dist/mermaid.min.js)                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| [KaTeX](https://katex.org/)                                                          | 0.18.7                   | 数式の表示                        | [katex.min.js](https://cdn.jsdelivr.net/npm/katex@0.18.7/dist/katex.min.js)、[auto-render.min.js](https://cdn.jsdelivr.net/npm/katex@0.18.7/dist/contrib/auto-render.min.js)、[katex.min.css](https://cdn.jsdelivr.net/npm/katex@0.18.7/dist/katex.min.css)                                                                                                                                                                                                                                                                                              |
| [Markdown-CSS](https://github.com/Star-Delta/Markdown-CSS)                           | @0                       | 本文の表示・印刷用スタイル        | [Markdown.css](https://cdn.jsdelivr.net/gh/Star-Delta/Markdown-CSS@0/Markdown.css)、[Markdown_Print.css](https://cdn.jsdelivr.net/gh/Star-Delta/Markdown-CSS@0/Markdown_Print.css)                                                                                                                                                                                                                                                                                                                                                                       |

一覧はHTMLが直接読み込むファイルです。完全ローカルで使用する場合は、ファイルを保存するだけでなく、`Markdown_Preview.html`内の読み込み先を保存したファイルの場所に変更する必要があります。

- KaTeXには、同じバージョンのフォントファイルも必要です。配布パッケージの`fonts`フォルダを、`katex.min.css`と同じフォルダ内に配置してください。[KaTeXの配布ファイルと配置方法](https://katex.org/docs/browser.html#download--host-things-yourself)
- Markdown-CSSの`@0`は個別のリリース番号への固定ではないため、配信されるファイルが更新される場合があります。
- 文書内の外部画像・動画・音声などもローカルファイルへ置き換える必要があります。

## ライセンス

このプロジェクトは [Mozilla Public License 2.0](./LICENSE) の下で提供されています。

## 作者

- 開発者：[Star-Delta](https://github.com/Star-Delta)
