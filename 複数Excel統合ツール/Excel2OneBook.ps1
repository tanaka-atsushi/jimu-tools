
#Excelを呼び出して表示
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true

#結合先ブックの用意
$targetWorkbook = $excel.Workbooks.Add()

#引数のファイルをソート
$args = $args | Sort-Object

#ファイルを開きながら1シート目をコピー
foreach($arg in $args){
    $sourceWorkbook  = $excel.Workbooks.Open($arg)
    foreach($sheet in $sourceWorkbook.Sheets){
        $sheet.Copy([System.Reflection.Missing]::Value, $targetWorkbook.Sheets.Item($targetWorkbook.Sheets.Count))
        }
    $sourceWorkbook.Close($false)
}

#結合先ブックの１シート目はゴミなので削除
if ( -not($targetWorkbook.Sheets.Count -eq 1) ){
    $targetWorkbook.Sheets.Item(1).Delete()
    }

#ファイル保存ダイアログの表示と保存
$fileName = $excel.GetSaveAsFilename([System.Reflection.Missing]::Value, "Excelファイル, *.xlsx")
if ( $fileName ){
    $targetWorkbook.SaveAs($fileName)
    }

#終了処理
$targetWorkbook.Close($false)
$excel.Quit()

# COMオブジェクトの解放
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

