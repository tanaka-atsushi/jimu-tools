while($true){

#西暦→和暦
while($true){

#変数の掃除
Remove-Variable -Name "hizuke" -ErrorAction SilentlyContinue

try{
    #ユーザーの入力受け
    $hizuke = Read-Host "西暦日付（例 2024.3.1、2024/4/1）を入力（Enterでモード変更）"
    
    #何も入力されずにエンターされた場合は、和暦→西暦へ
    if ([string]::IsNullOrEmpty($hizuke)){
        break
        }

    #型キャスト
    $hizuke = [Datetime]$hizuke

    #カルチャーの設定
    $CultureInfo = New-Object CultureInfo("ja-JP")
    $CultureInfo.DateTimeFormat.Calendar = New-Object System.Globalization.JapaneseCalendar

    #和暦に変換して出力
    $hizuke.ToString("gy年M月d日", $CultureInfo)

    }
catch{
    Write-Output "正常な西暦日付（例 2024.3.1、2024/4/1）ではありません"
}
}#------------------------------------

#和暦→西暦------------------------------------
while($true){

#変数の掃除
Remove-Variable -Name "hizuke" -ErrorAction SilentlyContinue

try{
    #ユーザーの入力受け
    $hizuke = Read-Host "和暦日付（例 R4.1.1）を入力（Enterでモード変更）"
    
    #何も入力されずにエンターされた場合は、西暦→和暦へ
    if ([string]::IsNullOrEmpty($hizuke)){
        break
        }

    #型キャスト
    $hizuke = [string]$hizuke

    #カルチャーの設定
    $CultureInfo = New-Object CultureInfo("ja-JP", $true)
    $CultureInfo.DateTimeFormat.Calendar = New-Object System.Globalization.JapaneseCalendar

    #西暦に変換して出力
    $hizuke = [datetime]::Parse($hizuke, $CultureInfo)
    $hizuke.ToString("yyyy/M/d")

    }

catch{
    Write-Output "正常な和暦日付（例 R4.1.1）ではありません"
}
}#------------------------------------


}