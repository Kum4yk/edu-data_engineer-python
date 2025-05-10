#!/bin/bash

# Создаем файл логов
cat <<EOL > access.log
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL

# Создаем отчет
{
    echo "Отчет о логе веб сервера"
    echo "==================="
    echo ""
    
    # 1. Общее количество запросов
    echo "1. Общее количество запросов:"
    awk 'END{print NR}' access.log
    echo ""
    
    # 2. Количество уникальных IP-адресов
    echo "2. Количество уникальных IP-адресов:"
    awk '{ip[$1]++} END{print length(ip)}' access.log
    echo ""
    
    # 3. Количество запросов по методам (исправленный формат)
    echo "3. Количество запросов по методам:"
    awk -F'"' '{print $2}' access.log | awk '{print $1}' | sort | uniq -c | awk '{print $2 ": " $1}'
    echo ""
    
    # 4. Самый популярный URL (исправленный формат)
    echo "4. Самый популярный URL:"
    awk -F'"' '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -nr | head -1 | awk '{print $2 ": " $1 " запросов"}'
    
} > report.txt

echo "Отчет успешно сохранен в report.txt"