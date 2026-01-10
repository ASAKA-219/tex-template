# tex template
このリポジトリはいくつかのTeXテンプレートを載せています。
スライド用とレポート用でコンパイル方法が違いますのでご注意ください。

## compile
まず、 $$\TeX$$ ファイルを`dvi`ファイルにコンパイルする必要があります。
エラーが出た場合は、Enterを押したら途中で止まると思いますので、修正しましょう。

- レポート用（文書）
以下のコマンドをターミナルで実行します。
```bash
uplatex main.tex
```

そして、`dvi`ファイルを`pdf`に変換します。
```bash
dvipdfmx main.dvi
```

するとpdfが生成されます。


- スライド用
以下のコマンドをターミナルで実行します。
```bash
xelatex main.tex
```
するとPDFが出力されます。

## テンプレート
３種類あり、
- 課題などの簡単な用は[こちら](templates/report/report.tex)
- 論文などの本用は[こちら](templates/book_report/book_report.tex)
- スライド用は[こちら](templates/slide/slide.tex)
です。

> update on 2026/1/10
