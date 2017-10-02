def import(file)
  # Проверям имя файла на корректность
  return puts 'Invalid name of file!' unless File.exist?(file)

  # Открываем файл и читаем построчно
  File.open(file).each do |io|

    # Получяем код ответа для текущей строки
    code_status = io.scan(/up_status="([\d]*)"/)[0] * " "

    # Заполняем массив временем ответа на успешные запросы
    if code_status.to_i == 200
      resp_time = io.scan(/x_resp_time="([\d]*.[\d]*)ms"/)[0] * " "
      $good_time.push(resp_time.to_f)
    end

    # Заполняем массив кодами ответов от неуспешных запросов
    if code_status.to_i != 200
      $bad_status.push(code_status.to_i)
    end
  end
end

def print
  # Создаем хэш для хранения кол-ва неупешных запросов
  bad_h = Hash.new
  $bad_status.uniq.each do |i|
    bad_h.store(i, 0)
  end

  # Заполняем хэш
  $bad_status.each do |i|
    bad_h.each do |key, value|
      if i == key
        bad_h[key] = value + 1
      end
    end
  end

  good_counter = $good_time.size
  bad_counter = $bad_status.size
  all_counter = good_counter + bad_counter
  avg_time = ($good_time.inject(0){ |sum, i| sum + i }.to_f) / good_counter

  # Выводим отчет по запросам
  puts "#{bad_counter} out of #{all_counter} requests returned non 200 code:"
  bad_h.each do |key, value|
    puts "#{key} - #{value}"
  end
  puts "Average response with 200 code: #{avg_time.to_i}ms from #{good_counter} requests."
end


$bad_status = Array.new
$good_time = Array.new

# Если не аргумент из консоли - берем значение по-умолчанию
ARGV[0] = 'nginx.txt' if ARGV[0].nil?
import(ARGV[0].to_s)
print_res
