
$dialog = New-Object -TypeName Microsoft.Win32.OpenFileDialog
$dialog.Filter = 'Aller Kram|*.*|Skripts|*.ps1|Bilder|*.jpg'
$dialog.ShowDialog()
$dialog.FileName
