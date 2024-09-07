@echo off

REM %~dp0：このバッチファイルのパス
REM %~n0：このバッチファイルのファイル名（拡張子なし）
REM %*：ドラッグ＆ドロップした場合の引数全体

powershell -executionpolicy RemoteSigned -File "%~dp0Excel2OneBook.ps1" %*