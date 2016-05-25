[xml]$config = get-content "$PSScriptRoot\config.xml" -ErrorAction SilentlyContinue

function connectDB($config) {
    try {
        #Store Connection parameters
        $connString = "Server="+$config.config.dbserver+";Uid="+$config.config.dbuser+";Pwd="+$config.config.dbpassword+";database="+$config.config.dbname;
        # load MySQL-Connector from assembly, don't use .dll in library name even if it's listed like this in the assembly path
        $r=[reflection.Assembly]::LoadWithPartialname("mysql.data");
        # create a new MySQL-connection object
        $conn = New-Object MySql.Data.MySqlClient.MySqlConnection;
        # link the connection parameters to the connection object
        $conn.ConnectionString = $connString;
        # finally: open the connection
        $conn.Open();
        return $conn
    }
    catch {
        Write-Host "Verbindung zum Datenbankserver fehlgeschlagen"
        & "$PSScriptRoot\config.ps1"
        [xml]$config = get-content "$PSScriptRoot\config.xml" -ErrorAction SilentlyContinue
        connectDB $config
    }

}

function existsMac($mac) {
    $command = New-Object MySql.Data.MySqlClient.MySqlCommand;
    $command.Connection = $conn;
    $command.CommandText = "select * FROM devices WHERE mac='$mac'";
    $reader = $command.ExecuteReader();
    if ($reader.Read()) {
        $result=$true;
    }
    else {
        $result=$false;
    }
    $reader.Close();
    return $result;
}

connectDB $config
existsMac 11:22:33:44:55:66
