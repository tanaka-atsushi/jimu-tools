while($true){

#����a��
while($true){

#�ϐ��̑|��
Remove-Variable -Name "hizuke" -ErrorAction SilentlyContinue

try{
    #���[�U�[�̓��͎�
    $hizuke = Read-Host "������t�i�� 2024.3.1�A2024/4/1�j����́iEnter�Ń��[�h�ύX�j"
    
    #�������͂��ꂸ�ɃG���^�[���ꂽ�ꍇ�́A�a������
    if ([string]::IsNullOrEmpty($hizuke)){
        break
        }

    #�^�L���X�g
    $hizuke = [Datetime]$hizuke

    #�J���`���[�̐ݒ�
    $CultureInfo = New-Object CultureInfo("ja-JP")
    $CultureInfo.DateTimeFormat.Calendar = New-Object System.Globalization.JapaneseCalendar

    #�a��ɕϊ����ďo��
    $hizuke.ToString("gy�NM��d��", $CultureInfo)

    }
catch{
    Write-Output "����Ȑ�����t�i�� 2024.3.1�A2024/4/1�j�ł͂���܂���"
}
}#------------------------------------

#�a�����------------------------------------
while($true){

#�ϐ��̑|��
Remove-Variable -Name "hizuke" -ErrorAction SilentlyContinue

try{
    #���[�U�[�̓��͎�
    $hizuke = Read-Host "�a����t�i�� R4.1.1�j����́iEnter�Ń��[�h�ύX�j"
    
    #�������͂��ꂸ�ɃG���^�[���ꂽ�ꍇ�́A����a���
    if ([string]::IsNullOrEmpty($hizuke)){
        break
        }

    #�^�L���X�g
    $hizuke = [string]$hizuke

    #�J���`���[�̐ݒ�
    $CultureInfo = New-Object CultureInfo("ja-JP", $true)
    $CultureInfo.DateTimeFormat.Calendar = New-Object System.Globalization.JapaneseCalendar

    #����ɕϊ����ďo��
    $hizuke = [datetime]::Parse($hizuke, $CultureInfo)
    $hizuke.ToString("yyyy/M/d")

    }

catch{
    Write-Output "����Șa����t�i�� R4.1.1�j�ł͂���܂���"
}
}#------------------------------------


}