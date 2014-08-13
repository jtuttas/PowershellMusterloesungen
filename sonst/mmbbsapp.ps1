# WICHTIGE Variablen (evl. anpassen)
$dbpassword="joerg123"
$dbserver="192.168.178.29"
$dbuser="tuttas"
$dbname="mmbbsapp"

function gen($kw) {

cls
# URLs des Stunden und des Vertretuzngsplans
$urlStdPLan="stundenplan.mmbbs.de/plan1011/klassen/frames/navbar.htm"
$urlVertrPlan="stundenplan.mmbbs.de/plan1011/ver_kla/frames/navbar.htm"
# Die Hashtables
$stdplan = @{}
$vplan = @{}
$klehrer=@{}
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
            #Write-Host  ("Lese Klassenlehrer");
            $url="stundenplan.mmbbs.de/plan1011/klassen/$kw/c/"
            $pattern="c00000"
            $pattern=$pattern.Substring(0,6-$i.ToString().length)
            $url=$url+$pattern+$i+".htm"
            $url
            $html = Invoke-WebRequest $url
            $html = $html.Content
            $html = $html.Split("`r`n");
            $line=$html[18]
            $lehrer="NN"
            if ($html[18].Length -gt 7) {
                $lehrer=$line.Substring(6);
            }
            if ($lehrer -match "&nbsp;") {
                $lehrer="NN";
            }
            Write-Host  ("Lese Klassenlehrer:"+$lehrer);
            #exit
            $klehrer.Add($klasse,$lehrer)
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

cls
# URLs des Stunden und des Vertretuzngsplans
$lurlStdPLan="stundenplan.mmbbs.de/plan1011/lehrkraft/plan/frames/navbar.htm"
$lurlVertrPlan="stundenplan.mmbbs.de/plan1011/ver_leh/frames/navbar.htm"
# Die Hashtables
$lstdplan = @{}
$lvplan = @{}
$kuerzel=@{}
Write-Host ("Lese Stundenplan Lehrer")
$html = Invoke-WebRequest $lurlStdPlan
$html = $html.Content
$html = $html.Split("`r`n");
$resultArray = @();
foreach ($zeile in $html) {
    if ($zeile -match "var teachers") {
        Write-Host ("+-- Var Teachers gefunden!")
        $zeile=$zeile.Substring($zeile.IndexOf("["))
        $zeile=$zeile.TrimStart("[");
        $zeile=$zeile.TrimEnd("];")
        $zeile=$zeile.Split(",")
        $i=1
        foreach ($teacher in $zeile) {
                    
            $teacher = $teacher.Substring(1,$teacher.length-2)

            $lstdplan.Add($i,$teacher)
            
            #stundenplan.mmbbs.de/plan1011/lehrkraft/plan/25/t/t00009.htm
            $url="stundenplan.mmbbs.de/plan1011/lehrkraft/plan/$kw/t/"
            $pattern="t00000"
            $pattern=$pattern.Substring(0,6-$i.ToString().length)
            $url=$url+$pattern+$i+".htm"
            $url
            $html = Invoke-WebRequest $url
            $html = $html.Content
            $html = $html.Split("`r`n");
            $lehrer=$html[15]
            Write-Host  ("Lese Kürzel $teacher ist $lehrer'n");
            $kuerzel.Add($i,$lehrer)
            $i++
        }   
        break;
    }
}

#$kuerzel
Write-Host ("Lese Vertretungsplan Lehrer")
$html = Invoke-WebRequest $lurlVertrPlan
$html = $html.Content
$html = $html.Split("`r`n");
$resultArray = @()
foreach ($zeile in $html) {
    if ($zeile -match "var teachers") {
        Write-Host ("+-- Var Teachers gefunden!")
        $zeile=$zeile.Substring($zeile.IndexOf("["))
        $zeile=$zeile.TrimStart("[");
        $zeile=$zeile.TrimEnd("];")
        $zeile=$zeile.Split(",")
        $i=1

        foreach ($klasse in $zeile) {               
            $klasse = $klasse.Substring(1,$klasse.length-2)                
            $lvplan.Add($i,$klasse)            
            $i++
        }   
        break
    }
}

Write-Host ("Schreiben in die Datenbank")
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
    [reflection.Assembly]::LoadWithPartialname("mysql.data");
    Write-Host ("DLL geladen")
    $conn = New-Object MySql.Data.MySqlClient.MySqlConnection;
    $conn.ConnectionString = $connString;
    $conn.Open();

    Write-Host ("Verbindung zur Datenbank hergestellt!")

    foreach($key in $stdplan.keys){
        $objekt = 'dummy' | Select-Object -Property Klasse, IDPlan, IDVPlan,IDLEHRER
        $objekt.Klasse=$key
        $objekt.IDPlan=$stdPlan[$key]
        $objekt.IDVPlan=$vplan[$key]
        $objekt.IDLEHRER=$klehrer[$key]

        $command = New-Object MySql.Data.MySqlClient.MySqlCommand;
        $command.Connection = $conn;


        $command.CommandText="INSERT INTO KLASSE (KNAME,STUNDENPLAN,VERTRETUNGSPLAN,ID_LEHRER) VALUES ('"+$objekt.Klasse+"',"+$objekt.IDPlan+","+$objekt.IDVPlan+",'"+$objekt.IDLEHRER+"') ON DUPLICATE KEY UPDATE STUNDENPLAN = "+$objekt.IDPlan+",VERTRETUNGSPLAN="+$objekt.IDVPlan+",ID_LEHRER='"+$objekt.IDLEHRER+"'"
        Write-Output $command.CommandText
        $reader = $command.ExecuteNonQuery();
    
    }
    #>
    foreach($key in $lstdplan.keys){
        $lobjekt = 'dummy' | Select-Object -Property Kuerzel, IDPlan, IDVPlan, Name
        $lobjekt.Kuerzel=$kuerzel[$key]
        $lobjekt.IDPlan=$key
        $lobjekt.IDVPlan=$key
        $lobjekt.Name=$lstdPlan[$key]

        


        $command = New-Object MySql.Data.MySqlClient.MySqlCommand;
        $command.Connection = $conn;


        #$command.CommandText = "UPDATE KLASSE SET STUNDENPLAN=$idStdplan,VERTRETUNGSPLAN=$idVplan,ID_LEHRER=`"$idLehrer`" WHERE KNAME=`"$key`";"
        $command.CommandText="INSERT INTO LEHRER (ID,NNAME,STUNDENPLAN,VERTRETUNGSPLAN) VALUES ('"+$lobjekt.Kuerzel+"','"+$lobjekt.Name+"',"+$lobjekt.IDPlan+","+$lobjekt.IDVPlan+") ON DUPLICATE KEY UPDATE STUNDENPLAN = "+$lobjekt.IDPlan+",VERTRETUNGSPLAN="+$lobjekt.IDVPlan
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
    $objekt = 'dummy' | Select-Object -Property Klasse, IDPlan, IDVPlan, IDLEHRER
    $objekt.Klasse=$key
    $objekt.IDPlan=$stdPlan[$key]
    $objekt.IDVPlan=$vplan[$key]
    $objekt.IDLEHRER=$klehrer[$key]
    $resultArray+=$objekt
    
}
$resultArray=$resultArray | sort { $_.Klasse}
$resultArray
}

$kw=get-date -uFormat %V
gen($kw)