$csv = Import-Csv "$HOME\ADbenutzer.csv"
foreach ($benutzer in $csv) {
    $pw = ConvertTo-SecureString -AsPlainText $benutzer.Kennwort  -Force
    $mail = $benutzer.Name+"@tuttas.de"
    New-ADUser -Name ($benutzer.Name) -Surname ($benutzer.Name) -GivenName ($benutzer.Vorname) -UserPrincipalName $mail -Enabled $true -AccountPassword  $pw
    Write-Host "Benutzer "$benutzer.Vorname" "$benutzer.Name" angelegt"
}