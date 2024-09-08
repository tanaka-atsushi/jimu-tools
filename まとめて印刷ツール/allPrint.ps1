#既定のアプリで印刷できなかった場合のアプリとコマンドの設定
$app_hash = @{
    ".txt" = @{
        app = "notepad.exe"
        cmd = "/P"
     }
    ".pdf" = @{
        app = "AcroRd32.exe"
        cmd = "/n /t"
    }
}

#その他細かい変更可能値の設定
$backup = "_起動時の設定.dat"
$sleep = 3

#デフォルトプリンタのオブジェクト取得
$Printer = Get-WmiObject -Query "Select * From Win32_Printer Where Default=$true"

#プリンタ設定ファイルの保存場所用の名前取得とフルパスの生成
$Folder = ($Printer.Name -split "\\")[-1]
$Path = Join-Path $PSScriptRoot $Folder

#プリンタ設定ファイル用のフォルダの作成
if( -not(Test-Path $Path) ){
    "プリンタ設定フォルダを生成します…"
    New-Item -ItemType Directory -Path $Path >$null
}

#スクリプト実行時のプリンタ設定のバックアップ
$backup = "$($Path)\$($backup)"
rundll32 printui.dll PrintUIEntry /Ss /n $Printer.Name /a $backup

#バックアップを非表示にする処理（→中止）
do{
}until(Test-Path $backup)
#Set-ItemProperty -Path $backup -Name Attributes -Value "Hidden" 2>&1>$null

#メニュー処理
:menu_loop while($true){
    #メニュー表示

    "---------------------------------------------------------------"
    "モード一覧"
    #作成日でプリンタ名フォルダ内のモードファイルをソートしてメニュー表示
    $list = (Get-ChildItem $Path\*.dat| Select-Object Name,CreationTime|Sort-Object CreationTime).Name
    $hash = @{}; $count = 0  #ハッシュテーブルの準備とカウンターの初期化
    foreach ($i in $list){
        $hash[[string]$count++] = $i
    }
    $hash.GetEnumerator() | Sort-Object -Property Name #ハッシュをソートして表示

    #オプション選択のメニュー表示
    "
    数値:選択したモードで印刷を開始します。
    e:規定のプリンタ設定GUIの表示
    s:現在の既定のプリンタの設定をモードとして保存
    r:モード一覧のリロード
    *:エンターもしくはその他のキー入力で現在の設定でプリント開始
    "

    #メニュー選択入力と処理の分岐
    $input = Read-Host "処理を入力してください"
    switch($input){
        ({$hash.ContainsKey($_)}){
            $file = Get-ChildItem -Path $Path -Filter $hash[$_] | Select-Object -ExpandProperty FullName
            rundll32 printui.dll PrintUIEntry /Sr /n $Printer.Name /a $file u
            "モードを読み込んでいます…"; Start-Sleep -Seconds $sleep
            break menu_loop
        }
        "e" {
            rundll32 printui.dll PrintUIEntry /n $Printer.Name /e
        }
        "s" {
            $input = Read-Host "モード名を入力してください（例：カラー両面２アップ）"
            rundll32 printui.dll PrintUIEntry /Ss /n $Printer.Name /a "$PSScriptRoot\$($Printer.ShareName)\${input}.dat"
            "保存中…"
            Start-Sleep -Seconds $sleep
            }
        "r" {
            continue
        }
        default { break menu_loop }
    }
}

#印刷ループ
"印刷を開始します…"
foreach($arg in $args){
    $arg
    try {
        Start-Process -FilePath $arg -Verb Print
    }
    catch {
        $ext = [System.IO.Path]::GetExtension($arg)
        Start-Process -FilePath $app_hash.Item($ext).app -ArgumentList @($app_hash.Item($ext).cmd, "`"$arg`"")
    }
}

#スクリプト実行時のプリンタ設定を復元
rundll32 printui.dll PrintUIEntry /Sr /n $Printer.Name /a $backup u
