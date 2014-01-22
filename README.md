# VnPrefecture

https://rubygems.org/gems/jp_prefecture

## vn_prefecture

Thư viện viết cho Ruby on Rails để tham khảo và sử dụng một cách dễ dàng các tên tỉnh thành của Việt Nam. 

Thư viện này được fetch từ thư viện cùng loại của Nhật là JpPrefecture.

Tên các tỉnh thành sẽ được định nghĩa bởi font Unicode.

```
Thái Bình : 26 -> 26
Hà Nội : 1 -> 1
```

参考: [Đại học Quốc Gia thành phố Hồ Chí Minh: 全国地方公共団体コード](http://aad.vnuhcm.edu.vn/tuyensinh/danhmuc/tinh.aspx)

都道府県コードと都道府県名のマッピングは変更することもできます。
詳しくは「都道府県のマッピング情報を変更する」の項目を参照してください。

また、Rails のプラグインとして使用することもできます。

## インストール

以下の行を `Gemfile` に記述してから:

```
gem 'jp_prefecture'
```

`bundle` を実行してください。

または、手動でインストールしてください:

```
$ gem install jp_prefecture
```

## 使い方

### ライブラリの読み込み

```ruby
require 'jp_prefecture'
```

### 都道府県コードから都道府県を検索

単純に都道府県コードを渡すと、都道府県コードから都道府県を検索します:

```ruby
pref = JpPrefecture::Prefecture.find 13
# => #<JpPrefecture::Prefecture:0x007fd0a3d43fe8 @code=13, @name="東京都", @name_e="Tokyo">
pref.code
# => 13
pref.name
# => "東京都"
pref.name_e
# => "Tokyo"
```

以下のように渡すことも可能です:

```ruby
JpPrefecture::Prefecture.find code: 13
```

### 都道府県名から都道府県を検索

```ruby
JpPrefecture::Prefecture.find name: "東京都"
# => #<JpPrefecture::Prefecture:0x007ff672271800 @code=13, @name="東京都", @name_e="Tokyo">

JpPrefecture::Prefecture.find name: "Tokyo"
# => #<JpPrefecture::Prefecture:0x007fb3c2828b10 @code=13, @name="東京都", @name_e="Tokyo">

JpPrefecture::Prefecture.find name: "tokyo"
# => #<JpPrefecture::Prefecture:0x007f965c0c5a40 @code=13, @name="東京都", @name_e="Tokyo">
```

### 都道府県の一覧を取得

```ruby
JpPrefecture::Prefecture.all
# => [#<JpPrefecture::Prefecture:0x007fd0a3d78d38 @code=1, @name="北海道", @name_e="Hokkaido">, ...]
```

### Rails(ActiveRecord) で使用する

`ActiveRecord::Base` を継承した Model で、都道府県コードを扱うことができます。

app/models/place.rb:

```ruby
class Place < ActiveRecord::Base
  # prefecture_code:integer

  include JpPrefecture
  jp_prefecture :prefecture_code
end
```

`prefecture` というメソッドが生成され、都道府県コード、都道府県名が参照できるようになります:

```ruby
place = Place.new
place.prefecture_code = 13
place.prefecture.name
# => "東京都"
```

生成されるメソッド名は `method_name` というオプションで指定することができます:

```ruby
# model
jp_prefecture :prefecture_code, method_name: :pref

place = Place.new
place.prefecture_code = 13
place.pref.name
# => "東京都"
```

### テンプレートで使用する

`collection_select` を使用して、都道府県のセレクトボックスを生成することができます。:

```ruby
f.collection_select :prefecture_code, JpPrefecture::Prefecture.all, :code, :name

# 英語表記で出力
f.collection_select :prefecture_code, JpPrefecture::Prefecture.all, :code, :name_e
```

### マイグレーション

カラムのタイプは `integer` か `string` で作成してください。

マイグレーションのサンプル:

```ruby
class AddPrefectureCodeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :prefecture_code, :integer
  end
end
```

### 都道府県のマッピング情報を変更する

デフォルトのマッピング情報以外のものを使用したい場合、以下のようにカスタマイズされた
マッピングデータを指定することができます:

```ruby
custom_mapping_path = "..." # /path/to/mapping_data

JpPrefecture.setup do |config|
  config.mapping_data = YAML.load_file custom_mapping_path
end
```

マッピングデータのフォーマットについては [prefecture.yml](https://github.com/chocoby/jp_prefecture/blob/master/data/prefecture.yml) を参考にしてください。

## ドキュメント

[http://rdoc.info/github/chocoby/jp_prefecture/master/frames/index](http://rdoc.info/github/chocoby/jp_prefecture/master/frames/index)

## TODO

GitHub の [Issues](https://github.com/chocoby/jp_prefecture/issues) を参照してください。

## 対象バージョン

* Ruby: 1.9.3 / 2.0.0 / 2.1.0
* Rails: 3.2.x / 4.0.x

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## GitHub

https://github.com/chocoby/jp_prefecture

## ライセンス

MIT: http://chocoby.mit-license.org/
