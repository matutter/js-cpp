@echo off

rem example of "wget" for windows
rem bitsadmin.exe /transfer "JobName" http://download.url/here.exe C:\destination\here.exe

set path=%path%;C:\Program Files\Java\jdk1.8.0_121\bin
set file_name=%1
set file_base_name=%2
set testrig_class=org.antlr.v4.runtime.misc.TestRig
set jar=antlr-4.7-complete.jar

if exist %jar% (
  echo %jar% found, building...
) else (
  echo %jar% missing, downloading...
  bitsadmin.exe /transfer "Download %jar%" "http://www.antlr.org/download/%jar%" "%~dp0%jar%"
  echo Please run build again
  EXIT [/B]
)

java -jar %jar% %file_name%
IF ERRORLEVEL 1 GOTO buildFailed

javac -cp .;%jar% %file_base_name%*.java
IF ERRORLEVEL 1 GOTO buildFailed

java -cp .;%jar% %testrig_class% %file_base_name% input -encoding utf8 -tokens -tree -gui ..\test\sample.c
IF ERRORLEVEL 1 GOTO buildFailed

EXIT [/B]

:buildFailed
  echo "Build failed"
