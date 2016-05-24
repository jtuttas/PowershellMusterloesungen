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

function getDevices ($conn) {
    $command = New-Object MySql.Data.MySqlClient.MySqlCommand;
    $command.Connection = $conn;
    $command.CommandText = "select * FROM devices";
    $reader = $command.ExecuteReader();
    $devices=@{};
    while($reader.Read())
    {
        $deviceObject = "" | Select-Object -Property "IP","DATE"
        $deviceObject.IP = $reader.GetString(1)        
        $deviceObject.DATE=$reader.GetString(2)
        $devices[$reader.GetString(0)]=$deviceObject;
    }
    $reader.Close();
    return $devices;
}

function insertDB ($conn,$client) {
    try {
        $command = New-Object MySql.Data.MySqlClient.MySqlCommand;
        $command.Connection = $conn;    
        $command.CommandText = "INSERT INTO devices (mac,ip,date) VALUES ('"+$client.MAC+"','"+$client.IP+"',now())"
        $res=$command.ExecuteNonQuery();
        Write-Host "Device"$c.MAC" zur Datenbank hinzugefügt"
    }
    catch {
        Write-Host "Device"$c.MAC" konnte nicht zu Datenbank hinzugefügt werden" -ForegroundColor Red
    }
}

function updateDB ($conn,$client) {
    try {
        $command = New-Object MySql.Data.MySqlClient.MySqlCommand;
        $command.Connection = $conn;    
        $command.CommandText = "UPDATE devices SET ip='"+$client.IP+"', date=now() WHERE mac='"+$client.MAC+"'"
        $res=$command.ExecuteNonQuery();
        Write-Host "Device"$c.MAC" in der Datenbank aktualisiert"
    }
    catch {
        Write-Host "Device"$c.MAC" konnte nicht in der Datenbank aktualisiert werden" -ForegroundColor Red
    }
}

<#
    Vergleicht ob eine IP Adresse kleiner ist als eine zweite IP Adresse
#>
function lowerThan ($ip1,$ip2) {
    [int[]]$a1 = $ip1.Split(".")
    [int[]]$a2 = $ip2.Split(".")
    if ($a1[0] -lt $a2[0]) {
        return $true
    }
    else {
        if ($a1[1] -lt $a2[1]) {
            return $true
        }
        else {
            if ($a1[2] -lt $a2[2]) {
                return $true
            }
            else {
                if ($a1[3] -lt $a2[3]) {
                    return $true
                }
                else {
                    return $false
                }
            }
        }
    }
    return $false;
}

<#
    Erhöhe eine IP Oktett um 1
#>

function incIp([int[]]$ip) {
    if ($ip[3] -eq 255) {
        $ip[3]=0
        if ($ip[2] -eq 255) {
            $ip[2]=0
            if ($ip[1] -eq 255) {
                $ip[1]=0
                if ($ip[0] -eq 255) {
                }
                else {
                    $ip[0]++;
                }
            }
            else {
                $ip[1]++;
            }
        }
        else {
            $ip[2]++;
        }
    }
    else {
        $ip[3]++;
    }
    return $ip
}

<#
    Pingt einen IP Bereich an 
#>

function pingRange($from,$to) {
    Write-Host "Ping from $from to $to"    
    $afrom = $from.split(".")
    $ato = $to.split(".")
    while (lowerThan $from $to) {
        Write-Host "Ping to $from"
        $result=Test-Connection -Count 1 -ComputerName $from -ErrorAction SilentlyContinue
        if ($result) {
            $result
        }
        $afrom=incIp $afrom
        $from=""+$afrom[0]+"."+$afrom[1]+"."+$afrom[2]+"."+$afrom[3]        
    }
}

<#
    Aus der Ausgabe des Befehls arp -a werden die Daten extrahier und in ein Objekt gewandelt
#>
function getArpClients ($apr) {
    # In dieser Liste werde alle gültigen Clients gespeichert    
    $clients=@()
    foreach ($a in $apr) {
        $i = $a.Split(" ")

        # Jeder Eintrag, der nicht nur aus Leerzeichen bestät wird in $items übernommen
        $items = @();
        foreach ($j in $i) {
            if ($j.length -ne 0) {
                $items+=$j
            }
        }

        
        # Gültiger Eintrag bei length=3 
        
        if ($items.length -eq 3) {
            #ARP Objekt erzeugen
            $arpObject = "" | Select-Object -Property "MAC","IP"
            $arpObject.IP = $items[0]
            $arpObject.MAC = $items[1]
            $clients+=$arpObject;
        }        
    }
    return $clients
}

if ($config) {
    Write-Host "Config Datei gefunden, aufbau der Datenbankverbindung"    

    # IP Bereich anpingen, damit Einträge in der apr Tabelle erscheinen
    pingRange $config.config.from $config.config.to

    # Arp Tabelle einlesen nach den PINGs und in eine Liste wandeln
    $arp=arp -a
    $clients= getArpClients $arp
    
    # Verbindung zur Datenbank Herstellen
    $conn = ConnectDB $config

    # Datenbank auslesen
    $devices = getDevices $conn

    # Neue MAC ADressen eintragen, alte aktualisieren
    foreach ($c in $clients) {
        if ($devices[$c.MAC]) {
            # MAC Adresse bekannt, also UPDATE
            updateDB $conn $c
        }
        else {
            # NEUE Mac Adresse also INSERT
           insertDB $conn $c
        }
    }
       
}
else {
    Write-Host "Config Datei nicht gefunden"
    & "$PSScriptRoot\config.ps1"
}