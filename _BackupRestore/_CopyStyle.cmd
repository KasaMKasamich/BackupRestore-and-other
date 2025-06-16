@echo off
@echo "%date% %time% ***Starting copy style.default.css***"
cd /d "C:\xampp\htdocs\public_html\admin-7dtd\css\"
mkdir "G:\_Servers\WWW\public_html\admin-7dtd\css"
copy /Y "style.default.css" "C:\xampp\htdocs\public_html\Asguard-7days2die\css\style.default.css"
@timeout 1
copy /Y "style.default.css" "G:\_Servers\WWW\public_html\admin-7dtd\css\style.default.css"
