# jptxt

`jptxt` is a collection of tools that I developed for working with Japanese-language texts.

## Text segmentation

These tools rely on [MeCab](https://taku910.github.io/mecab/) to segment Japanese texts and identify parts of speech. Use `./src/segment.sh` to process batches of text with MeCab.

For example, `./tests/texts` contains two files:

- `maihime.txt`: The opening two paragraphs of [*Maihime*](https://www.aozora.gr.jp/cards/000129/card2078.html) 舞姫 \[The dancing girl\] (1890), by Mori Ōgai 森鴎外 (1862--1922).
- `wagahai.txt`: The opening two paragraphs of [*Wagahai wa Neko de aru*](https://www.aozora.gr.jp/cards/000148/card789.html) 吾輩は猫である \[I am a cat\] (1905), by Natsume Sōseki 夏目漱石 (1867--1916).

Use `./src/segment.sh` to segment the texts and write the output to `./tests/segmented`:

```{.bash}
$ head -n 1 ./tests/texts/wagahai.txt
吾輩は猫である。名前はまだ無い。
$ ./src/segment.sh ./tests/texts ./tests/segmented
Segmented: ./tests/segmented/maihime-segmented.csv
Segmented: ./tests/segmented/wagahai-segmented.csv
$ head ./tests/segmented/wagahai-segmented.csv
吾輩,我が輩,ワガハイ,代名詞,,,,1
は,は,ハ,助詞,係助詞,,,1
猫,猫,ネコ,名詞,普通名詞,一般,,1
で,だ,ダ,助動詞,,,,1
ある,有る,アル,動詞,非自立可能,,,1
。,。,,補助記号,句点,,,1
名前,名前,ナマエ,名詞,普通名詞,一般,,1
は,は,ハ,助詞,係助詞,,,1
まだ,未だ,マダ,副詞,,,,1
無い,無い,ナイ,形容詞,非自立可能,,,1
```

