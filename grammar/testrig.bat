@echo off

set path=%path%;C:\Program Files\Java\jdk1.8.0_121\bin
set file_name=%1
set file_base_name=%2
set testrig_class="org.antlr.v4.runtime.misc.TestRig"
set jar="antlr-4.7-complete.jar"

java -jar %jar% %file_name%
IF ERRORLEVEL 1 GOTO buildFailed

javac -cp .;%jar% %file_base_name%*.java
IF ERRORLEVEL 1 GOTO buildFailed

java -cp .;%jar% %testrig_class% %file_base_name% input -encoding utf8 -tokens -tree -gui ..\test\sample.c
IF ERRORLEVEL 1 GOTO buildFailed

EXIT [/B]

:buildFailed
  echo "Build failed"
