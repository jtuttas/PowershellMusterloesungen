$heute = Get-Date
$stichtag = $heute.AddDays(-20)

dir $env:windir -Filter *.log | 
  Where-Object -FilterScript { $_.LastWriteTime -gt $stichtag}




