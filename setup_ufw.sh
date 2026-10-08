#!/bin/bash

# Đảm bảo tập lệnh chạy dưới quyền sudo/root
if [ "$EUID" -ne 0 ]; then
  echo "Vui lòng chạy script với quyền sudo hoặc root!"
  exit 1
fi

echo "=== Bắt đầu cấu hình tường lửa UFW ==="

# Khôi phục UFW về trạng thái mặc định ban đầu
echo "y" | ufw reset

# Thiết lập chính sách mặc định
echo "Cấu hình chính sách mặc định: Chặn incoming, Cho phép outgoing..."
ufw default deny incoming
ufw default allow outgoing

# Cho phép các cổng dịch vụ theo yêu cầu
echo "Cho phép cổng SSH (22/tcp)..."
ufw allow 22/tcp

echo "Cho phép cổng Web HTTP (80/tcp)..."
ufw allow 80/tcp

echo "Cho phép cổng Spring Boot (8082/tcp)..."
ufw allow 8082/tcp

# Kích hoạt UFW
echo "Kích hoạt tường lửa UFW..."
echo "y" | ufw enable

# Kiểm tra trạng thái tường lửa
echo "=== Trạng thái UFW sau cấu hình ==="
ufw status verbose
