$ok=$false
do {
    try {
        $connString = "Server=localhost;Uid=tuttas;Pwd=joerg123;database=wol";
        # load MySQL driver and query database
        [void][system.reflection.Assembly]::LoadFrom("MySQL.Data.dll");
        $conn = New-Object MySql.Data.MySqlClient.MySqlConnection;
        $conn.ConnectionString = $connString;
        $conn.Open();
        $ok=$true;
    }
    catch {
        . $PSScriptRoot\Config.ps1
        $ok=$false
    }
}
while ($ok -eq $false)

