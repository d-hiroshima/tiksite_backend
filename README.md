## 環境概要
PHP8.3
MySQL8.0
nginx
Laravel11

## ローカル環境構築手順
1. ルートディレクトリで`docker-compose up -d --build`を実行。
2. **すでにプロジェクトが生成されている場合は3へ** Laravelのプロジェクトがない場合は`docker-compose exec app composer create-project --prefer-dist laravel/laravel:^11.0 src`を実行。バージョンを任意で指定をする場合は末尾に`:^version`を追記する。本プロジェクトはバージョン11を採用。
3. コンテナに入る`docker-compose exec -u www-data app bash`のあとに`cd laravel`
   1. `ln -s public storage/app/public`を実行。
   2. `composer install`を実行。
   3. 新たにインストールされた依存関係のためにLaravelのオートローダを再生成`composer dump-autoload`
   4. `php artisan migrate`を実行
   5. `php artisan storage:link`を実行