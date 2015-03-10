param($kennwort)
$script={
param($pw)
try {
  $user=Get-ADUser -Filter {EmailAddress -like "jtuttas@gmx.net"} -Properties EmailAddress 
  $newpwd=ConvertTo-SecureString -String $pw -AsPlainText -Force
  Set-ADAccountPassword $user -NewPassword $newpwd -Reset -PassThru | Set-ADUser -ChangePasswordAtLogon $true
  return "Kennwort geändert zu $pw"
}
catch  {
  return "Es ist ein Fehler aufgetreten"
}
}
$username="Administrator"
      if (Test-Path C:\Temp\admin.txt) {
        Write-Host "Found Secure String"
        $password = Get-Content C:\Temp\admin.txt | convertto-securestring
        $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
      }
      else {
            $cred = Get-Credential -UserName $username -Message "Kennwort f. Administrator"
            ConvertFrom-SecureString $cred.Password | Set-Content C:\Temp\admin.txt
      }
Invoke-Command -ComputerName 10.1.100.0 -Credential $cred -ScriptBlock $script -ArgumentList $kennwort
