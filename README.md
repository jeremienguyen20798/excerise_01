# excerise_01 - Ứng dụng: Đồng Hồ Báo Thức

# Mô tả về dự án: Một ứng dụng báo thức đơn giản, sử dụng flutter framework để handle UI. Về kiến trúc thì sử dụng clean architecture để quản lý source dự án và cuối cùng flutter_bloc được sử dụng để quản lý state trong dự án.
# Ngoài ra, tôi có sử dụng Isolate và StreamController.boardcast() để handle UI khi người dùng thực hiện các action với thông báo mỗi khi có báo thức đến.

# CÁC TÍNH NĂNG TRONG ỨNG DỤNG
# - Các tính nănng:
#   + Đặt, chỉnh sửa và xóa báo thức
#   + Hiển thị danh sách báo thức
#   + Thay đổi trạng thái báo thức
#   + Thay đổi ngôn ngữ
#   + Hiển thị danh sách nhạc chuông
#   + Set nhạc chuông cho mỗi báo thức
#   + Tải xuống nhạc chuông