# Nginx log parser

Консольное ruby-приложение для получения статисткики из [nginx](https://www.nginx.com) лога.
Пример отчета:

  ```
  10 out of 100 requests returned non 200 code:
  401 - 1
  404 - 3
  503 - 6
  Average response with 200 code: 900ms from 90 requests.
  ```

## Запуск

1. Запуск без параметров (используется url по-умолчанию):
   ```
   cd /path/to/project/dir
   ruby reader.rb
   ```

1. Запуск с указанием url:
   ```
   cd /path/to/project/dir
   ruby reader.rb nginx_lite.log
   ```   
