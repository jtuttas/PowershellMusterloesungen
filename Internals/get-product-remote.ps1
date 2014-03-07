$comps = Import-Csv "$Home\computer.csv"
foreach ($c in $comps) {
    $pw= ConvertTo-SecureString $c.Password -AsPlainText -Force
    $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $c.User, $pw
    $prod =Get-WmiObject win32_product -ComputerName $c.ComputerName -Credential $cred
    foreach ($p in $prod) {
        $product = 'product' | Select-Object -Property Name, Date
        $product.Name = $p.Name
        $product.Date = $p.InstallDate
        $product
    }
}