@echo off
chcp 65001 > nul
echo Setting up Django Blog environment...

REM Kiểm tra Python đã được cài đặt chưa
python --version > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python không được tìm thấy! Hãy cài đặt Python trước.
    exit /b 1
)

REM Kiểm tra và tạo môi trường ảo nếu chưa có
if not exist venv (
    echo Tạo môi trường ảo...
    python -m venv venv
    if %ERRORLEVEL% NEQ 0 (
        echo Không thể tạo môi trường ảo!
        exit /b 1
    )
)

REM Kích hoạt môi trường ảo
echo Kích hoạt môi trường ảo...
call venv\Scripts\activate

REM Kiểm tra lỗi khi kích hoạt môi trường
if %ERRORLEVEL% NEQ 0 (
    echo Không thể kích hoạt môi trường ảo!
    exit /b 1
)

REM Cài đặt các thư viện từ requirements.txt
echo Cài đặt các thư viện...
pip install --upgrade pip
pip install -r requirements.txt
if %ERRORLEVEL% NEQ 0 (
    echo Cài đặt thư viện thất bại!
    exit /b 1
)

REM Di chuyển vào thư mục project
cd myblog || exit /b 1

REM Thực hiện migrations
echo Thực hiện migrations...
python manage.py migrate
if %ERRORLEVEL% NEQ 0 (
    echo Lỗi khi chạy migrations!
    exit /b 1
)

REM Chạy server Django
echo Khoi donngng server Django...
echo Server đang chạy tại http://127.0.0.1:8000/
python manage.py runserver

REM Giữ terminal mở để kiểm tra lỗi
pause
