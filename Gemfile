source "https://rubygems.org"

# Rails本体
gem "rails", "~> 8.0.4" # バージョンは今のままでOK

# 開発(development)とテスト(test)だけで使うツール
group :development, :test do
  # 自分のPCでは SQLite3 を使う
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

# 開発環境だけで使うツール
group :development do
  gem "web-console"
end

# --- ここが重要！本番(production)だけで使うツール ---
group :production do
  # Render（本番環境）では PostgreSQL を使う
  gem "pg"
end

# AWS S3 連携（Active Storage用）
gem "aws-sdk-s3", require: false

# その他の共通Gem
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "sprockets-rails"
gem "jbuilder", "~> 2.11"
gem "tzinfo-data", platforms: [ :mingw, :mswin, :x64_mingw, :jruby ]
gem "bootsnap", require: false
