# 課題提出物マネージャ（report_manager_app）

学校の課題ごとに、提出物（**URL / 画像 / Word ファイル**）をまとめて管理する Rails アプリ。種類の違う提出物を1つのタスクの下に並べ、種類に応じた見た目と開き方で扱う。

**Ruby on Rails 8.0.4 / PostgreSQL / Active Storage + S3 / Render**

---

## 解決した課題

課題ごとに「提出用のスプレッドシートの URL」「スクリーンショット」「レポートの Word ファイル」が散らばっていて、提出直前にどこに置いたか探すことになっていた。1つのタスクに対して**異種の提出物をまとめて紐づける**形にした。

## 設計上の工夫

### 種別ごとの `if` 分岐を並べない

提出物は URL・画像・Word の3種類あり、それぞれ「アイコン」「リンクのテキスト」「開く先のパス」が違う。ビューに `if data_type == "url"` を並べると、種別が増えるたびに全箇所を直すことになる。

そこで**種別名からクラス名を組み立てて委譲する**形にした。

```ruby
class Datum < ApplicationRecord
  belongs_to :task
  has_one_attached :file

  def opener
    class_name = "#{data_type.camelize}Opener"
    class_name.constantize.new(self)
  end
end
```

`BaseOpener` が既定の振る舞い（アイコン `📄`）を持ち、各種別がそれを上書きする。

| クラス | アイコン | `target_path` |
| --- | --- | --- |
| `UrlOpener` | 🌐 | `@datum.content`（URL 文字列） |
| `ImageOpener` | 🖼️ | `@datum.file`（Active Storage の添付） |
| `WordOpener` | 📝 | `@datum.file` |

ビューは `datum.opener.icon` のように呼ぶだけで、種別を知らない。**提出物の種類を追加するときはクラスを1つ足すだけ**で、既存コードに手を入れる必要がない。

### タスクと提出物の関係

```ruby
class Task < ApplicationRecord
  has_many :data_list, class_name: "Datum", dependent: :destroy
end
```

提出物は常にタスクに属するため、ルーティングもネストさせて「どのタスクへの追加か」を URL で表現している。

```ruby
root 'tasks#index'
resources :tasks do
  resources :data, only: [:new, :create, :destroy]
end
```

`dependent: :destroy` でタスクを消せば提出物も消える。孤児レコードが残らないようにモデル側で保証した。

### ファイルの置き場所

画像と Word ファイルは Active Storage で扱い、本番では S3（`aws-sdk-s3`）に保存する。Render のファイルシステムはデプロイごとに揮発するため、アップロードしたファイルをアプリのディスクに置く選択肢はない。

## データ構造

```
tasks : id, title
data  : id, content, data_type, task_id
```

`content` は URL のときだけ使い、ファイル系は Active Storage の添付（`file`）側に持たせている。`data_type` が `opener` のクラス解決に使われる唯一のキー。

## 構成

```
app/
├── models/
│   ├── task.rb
│   └── datum.rb          # opener で種別クラスへ委譲
├── openers/
│   ├── base_opener.rb
│   ├── url_opener.rb
│   ├── image_opener.rb
│   └── word_opener.rb
├── controllers/
│   ├── tasks_controller.rb
│   └── data_controller.rb
└── views/tasks, data
render-build.sh           # Render のビルドスクリプト
```

## セットアップ

```bash
bundle install
rails db:create db:migrate
rails s
```

## 制約

- **認証を持たない。** 自分用のツールとして作っており、ユーザーごとのデータ分離はしていない
- 本番の `cache_store` は `memory_store`、`solid_queue` は無効化している。Render の無料プランで追加のサービスを立てずに動かすための割り切り（この経緯はコミット履歴に残っている）
- テストは書いていない
