cls
# URLs des Stunden und des Vertretuzngsplans
$urlStdPLan="stundenplan.mmbbs.de/plan1011/klassen/frames/navbar.htm"
$urlVertrPlan="stundenplan.mmbbs.de/plan1011/ver_kla/frames/navbar.htm"
# Die Hashtables
$stdplan = @{}
$vplan = @{}
Write-Debug ("Lese Stundenplan")
$html = Invoke-WebRequest $urlStdPlan
$html = $html.Content
$html = $html.Split("`r`n");
$resultArray = @();
foreach ($zeile in $html) {
    if ($zeile -match "var classes") {
        Write-Debug ("+-- Var Classes gefunden!")
        $zeile=$zeile.Substring($zeile.IndexOf("["))
        $zeile=$zeile.TrimStart("[");
        $zeile=$zeile.TrimEnd("];")
        $zeile=$zeile.Split(",")
        $i=1

        foreach ($klasse in $zeile) {
            
            $klasse = $klasse.Substring(1,$klasse.length-2)
            $stdplan.Add($klasse,$i)
            $i++
        }   
        break;
    }
}
Write-Debug ("Lese Vertretungsplan")
$html = Invoke-WebRequest $urlVertrPlan
$html = $html.Content
$html = $html.Split("`r`n");
$resultArray = @()
foreach ($zeile in $html) {
    if ($zeile -match "var classes") {
        Write-Debug ("+-- Var Classes gefunden!")
        $zeile=$zeile.Substring($zeile.IndexOf("["))
        $zeile=$zeile.TrimStart("[");
        $zeile=$zeile.TrimEnd("];")
        $zeile=$zeile.Split(",")
        $i=1

        foreach ($klasse in $zeile) {               
            $klasse = $klasse.Substring(1,$klasse.length-2)                
            $vplan.Add($klasse,$i)
            $i++
        }   
        break
    }
}


Write-Debug ("Schreiben in die Datenbank")
$dbpassword="joerg123"
$dbserver="192.168.178.6"
$dbuser="tuttas"
$dbname="mmbbsapp2"
# the connection string used to connect to the database
$connString = "Server="+$dbserver+";Uid="+$dbuser+";Pwd="+$dbpassword+";database="+$dbname;
#$connString
#
# get the script’s execution path
$myPath = get-Location
#$myPath

#
# load MySQL driver and query database
try {
    [void][system.reflection.Assembly]::LoadFrom($myPath.Path+"\MySqlData.dll");
    $conn = New-Object MySql.Data.MySqlClient.MySqlConnection;
    $conn.ConnectionString = $connString;
    $conn.Open();

    foreach($key in $stdplan.keys){
        $objekt = 'dummy' | Select-Object -Property Klasse, IDPlan, IDVPlan
        $objekt.Klasse=$key
        $objekt.IDPlan=$stdPlan[$key]
        $objekt.IDVPlan=$vplan[$key]

        $command = New-Object MySql.Data.MySqlClient.MySqlCommand;
        $command.Connection = $conn;

        $idStdplan = "c00000"
        [String]$value = $stdplan[$key]
        $idStdplan = $idStdplan.Substring(0,6-$value.Length)+$stdplan[$key]
        $idVplan = "c00000"
        [String]$value = $vplan[$key]
        $idVplan = $idStdplan.Substring(0,6-$value.Length)+$vplan[$key]

        $command.CommandText = "INSERT INTO KLASSE (KNAME,STUNDENPLAN,VERTRETUNGSPLAN) VALUES ('"+$key+"','"+$idStdplan+"','"+$idVplan+"');"
        Write-Output $command.CommandText
        $reader = $command.ExecuteNonQuery();
    
    }


    $conn.Close();
}
catch {
    Write-Error "Das Schreiben in die Datenbank hat nicht geklappt"
}

Write-Host ("Erzeuge Result Objekt")
foreach($key in $stdplan.keys){
    $objekt = 'dummy' | Select-Object -Property Klasse, IDPlan, IDVPlan
    $objekt.Klasse=$key
    $objekt.IDPlan=$stdPlan[$key]
    $objekt.IDVPlan=$vplan[$key]
    $resultArray+=$objekt
    
}
$resultArray=$resultArray | sort { $_.Klasse}
$resultArray
