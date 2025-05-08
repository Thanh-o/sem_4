@echo off
chcp 65001 >nul
title ★★★ HACKING SIMULATION - TROLL MODE 💻💥 ★★★
mode con: cols=100 lines=30
color 0A


:: Nhấp nháy màu như hiệu ứng hack
for /l %%i in (1,1,5) do (
    color 0A
    ping -n 1 127.0.0.1 >nul
    color 0C
    ping -n 1 127.0.0.1 >nul
)

:: HACKING EFFECT WITH EMOJIS
setlocal enabledelayedexpansion
set "spinner=| / - \"
for /l %%i in (1,1,10) do (
    for %%j in (!spinner!) do (
        <nul set /p=🔍 Dang quet he thong... %%j
        ping -n 1 127.0.0.1 >nul
        cls
    )
)

echo.
echo 🛰️ [*] Dang ket noi voi NASA...
timeout /t 1 >nul
echo 🔐 [*] Dang bypass firewall NASA... ✅
timeout /t 1 >nul
echo 🕵️‍♂️ [*] Truy cap server FBI...
timeout /t 1 >nul
echo 📡 [*] Tiep can thong tin mat...
timeout /t 1 >nul
echo 💘 [*] Dang tim vi tri cua crush...
timeout /t 2 >nul
echo ❌ [!] Loi! Crush dang an danh 🥲

:: TIẾNG CƯỜI ÁC LÚC TỰ HỦY
echo 💥 [!] Kich hoat che do TU HUY...
powershell -c (New-Object Media.SoundPlayer "C:\Boss\GitHub\sem4\sound\troll.wav").PlaySync();
timeout /t 2 >nul

color 0C


color 0E
echo.
echo =====================================================
echo 💖 EM CO YEU ANH KHONG? 💖
echo (Tra loi bang: CO / KHONG)
echo =====================================================
set /p love=💬 Tra loi cua em: 

if /i "%love%"=="co" goto love
if /i "%love%"=="khong" goto hate
goto invalid

:love
color 0D
powershell -c (New-Object Media.SoundPlayer "C:\Boss\GitHub\sem4\sound\troll.wav").PlaySync();
echo.
echo 💗 O troi oi!!! Anh da mong cau tra loi nay 💗
echo 🥰 Em da kich hoat che do “HANH PHUC TOAN TAP” 💫
for /l %%i in (1,1,5) do (
    echo ❤️💖💘💝💗💞💕💓
    timeout /t 1 >nul
)
echo 😍 Anh se ghi nho cau tra loi cua em suot doi...
timeout /t 3 >nul
echo 💤 May tinh se tat sau 10 giay nhe... ngu ngon 💻💤
timeout /t 10 >nul
goto end

:hate
color 04
echo.
echo 💔 Oh no... Anh biet ma... 😭
echo 😔 Anh ton trong cau tra loi cua em...
for /l %%i in (1,1,5) do (
    echo 💔💔💥💔💥💔💥
    timeout /t 1 >nul
)
echo 😢 May tinh se tu tat sau 10 giay... T.T
timeout /t 10 >nul
goto end

:invalid
color 06
echo.
echo ⚠️ Cau tra loi khong hop le! He thong dang gian du... 💣💣💣
for /l %%i in (1,1,5) do (
    color 0C
    echo 🚨🚨🚨 ERROR 🚨🚨🚨
    ping -n 1 127.0.0.1 >nul
    color 0E
    echo ⚡⚡⚡ SYSTEM CRITICAL ⚡⚡⚡
    ping -n 1 127.0.0.1 >nul
)
echo 💥 Tu dong tat may sau 5 GIAY!
timeout /t 5 >nul
goto end

:end
exit
