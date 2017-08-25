zousan package
==============

Tools library which @kazutan often uses. Almost all functions are designed for @kazutan .

このリポジトリは，kazutanがよく使う道具をまとめたパッケージです。ほとんどkazutanのために作ってますので，他の利用者のことは考慮していません。

関数一覧
--------

### `new_rmd_ja()`

日本語を使用するR Markdownドキュメントを念頭に，新規でRmdファイルを生成する関数です。

### `zousan_document()`

`rmarkdown::html_document()`を継承し，日本語用に設定を調整し，自作プラグインを盛り込んだもの。普通のhtml\_documentとしても使えます。

#### 変更した設定

-   self\_containedをデフォでFALSE
-   md\_extensions = "-ascii\_identifiers"

#### 追加したプラグイン

-   katex(デフォルトはFALSE)
-   lightbox
-   showhide
-   bs\_panel
-   bs\_label
-   bs\_badge
-   list\_address

### `set_prj()`

プロジェクトを作成した直後に，kazutanがよく使うディレクトリ構成を自動的に準備する関数です。

### `carousel()`

Rmd内にBootstrapのスライドショー(carousel)を組み込むためのhtmlを生成する関数です。

### `embed_slide()`

Rmd内にslideshareなどのスライドを埋め込むための関数です。
