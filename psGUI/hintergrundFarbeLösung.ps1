$myF = New-Object System.Windows.Forms.Form
$myF.Show();
$myF.Text="Hintergrundfarbe"
do {
   $a=Read-Host("q = Fenster schließen")
   
   if ($a -eq "r") {$myF.BackColor="red"}
   elseif ($a -eq "g"){$myF.BackColor="green"}
   elseif ($a -eq "b"){$myF.BackColor="blue"}
   else {$myF.backcolor="white"}
  
}
while ($a -ne "q")

$myF.Close()
