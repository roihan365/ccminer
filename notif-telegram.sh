#!/bin/bash

# Konfigurasi Bot Telegram
BOT_TOKEN="7770596919:AAF5zemIfNVZ_GleJnTin6NfJfGtvXtG7vk"
CHAT_ID="505717277" 
SCREEN_ID="4070" 

# Fungsi untuk mengirim log ke Telegram sebagai teks
send_log_to_telegram() {
    LOG_TEXT=$(screen -S "$SCREEN_ID" -X hardcopy /tmp/screen_log.log && tail -n 20 /tmp/screen_log.log)

    # Cek apakah LOG_TEXT tidak kosong
    if [ -n "$LOG_TEXT" ]; then
        # Kirim log sebagai pesan teks ke Telegram
        curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
             -d chat_id="$CHAT_ID" \
             -d text="$LOG_TEXT" \
             -d parse_mode="HTML"
    else
        echo "No new log to send."
    fi
}

while true; do
    send_log_to_telegram
    sleep 3600  # Ubah sesuai kebutuhan (dalam detik) 
done
