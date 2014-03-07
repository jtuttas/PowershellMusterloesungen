$comps = Import-Csv "$Home\computer.csv"
foreach ($c in $comps) {
    $pw= ConvertTo-SecureString $c.Password -AsPlainText -Force
    $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $c.User, $pw
    Invoke-Command -ComputerName $c.ComputerName -Credential $cred -Command {Get-Process | Sort-Object -Property cpu -descending | Select-Object -First 3}
}