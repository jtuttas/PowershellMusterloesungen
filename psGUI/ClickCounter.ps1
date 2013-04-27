$global:klicks=0
$myF = New-Object System.Windows.Forms.Form
$b = New-Object System.Windows.Forms.Button
$l = New-Object System.Windows.Forms.Label
$l.Text = "Klicks 0"
$l.Location="10,50"
$b.Text="Klick mich"
$b.Location="10,20"
$l.Add_MouseHover({
    $global:klicks=0
    $l.Text="Klicks "+$global:klicks
})
$b.Add_Click({
    $global:klicks++;
    $l.Text="Klicks "+$global:klicks
})
$myF.Controls.add($b)
$myF.Controls.add($l)
$myF.Text="Klick Counter"
$myF.ShowDialog();