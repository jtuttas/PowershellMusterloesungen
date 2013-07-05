$connString = "Server=localhost;Uid=tuttas;Pwd=joerg123;database=wol";
# load MySQL driver and query database
[void][system.reflection.Assembly]::LoadFrom("MySQL.Data.dll");
$conn = New-Object MySql.Data.MySqlClient.MySqlConnection;
$conn.ConnectionString = $connString;
$conn.Open();

