$myF = New-Object System.Windows.Forms.Form
$b = New-Object System.Windows.Forms.Button
$b1 = New-Object System.Windows.Forms.Button

$b.Text="Klick"
$b.Location="10,20"

$b1.text = "mich"
$b1.location = "10,60"


$myF.Controls.add($b)
$myF.controls.add($b1)

$myF.Text="Ein Element dem Container hinzufügen"
$myF.ShowDialog()
