# Tage bis Nikolaus
cls
$nikolaus=New-Object System.DateTime(2011,12,6)
$today = Get-Date
$nikolausTag=$nikolaus.get_DayOfYear()
$todayTag=$today.get_DayOfYear()
Write-Host ("Es sind noch "+($nikolausTag-$todayTag)+" Tage bis Nokilaus")