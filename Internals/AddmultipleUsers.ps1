$csv = Import-Csv "$HOME\ADbenutzer.csv" -Encoding Default

foreach ($benutzer in $csv) {
    $pw = ConvertTo-SecureString -AsPlainText $benutzer.Kennwort  -Force
    $mail = $benutzer.Name+"@tuttas.de"
    try {
        New-ADUser -Name (($benutzer.Name)+" "+$benutzer.Vorname) -Surname ($benutzer.Name) -GivenName ($benutzer.Vorname) -UserPrincipalName $mail -Enabled $true -AccountPassword  $pw
        Write-Host "Benutzer"$benutzer.Vorname$benutzer.Name"angelegt" -ForegroundColor Green
    }
    catch {
       Write-Host "Beim Anlegen des Benutzers"($benutzer.Vorname)($benutzer.Name)"ist ein Fehler aufgetreten" -ForegroundColor Red
    }
}
