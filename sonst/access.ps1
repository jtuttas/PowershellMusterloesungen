# DB Pfad zur Access Datenbak
$path = "E:\Dokumente\Datenbank1.accdb"
$adOpenStatic = 3
$adLockOptimistic = 3
 
$cn = new-object -comobject ADODB.Connection
$rs = new-object -comobject ADODB.Recordset
 
$cn.Open("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=$path")
$rs.Open("Select * From User", $cn,$adOpenStatic,$adLockOptimistic)
 
$rs.MoveFirst()
 
do {
    
    $name  = $rs.Fields.Item("Name").Value;
 
    $name
    $rs.MoveNext()
} 
until ($rs.EOF -eq $True)
 
$rs.close()
$cn.close()
