@echo off

REM %~dp0�F���̃o�b�`�t�@�C���̃p�X
REM %~n0�F���̃o�b�`�t�@�C���̃t�@�C�����i�g���q�Ȃ��j
REM %*�F�h���b�O���h���b�v�����ꍇ�̈����S��

powershell -executionpolicy RemoteSigned -File "%~dp0Excel2OneBook.ps1" %*