$myF = New-Object System.Windows.Forms.Form
$myL = new-object System.Windows.Forms.Label
$myL.Text = "Black"
$myL.Location = "30,30"

$myF.Text="Ein Label dem Container hinzufügen"
$myF.controls.add($myL)
$myF.Show()

do {
   $a=Read-Host("q = Fenster schließen")
   if ($a -eq "r") 
    {$myL.Text = "red" 
     $myL.ForeColor="red"
    }
   elseif ($a -eq "g")
    {$myL.Text = "green"
    $myL.ForeColor="green"
    }
   elseif ($a -eq "b")
    {$myL.Text = "blue"
    $myL.ForeColor="blue"
    }
   else 
    {$myL.Text = "Black"
    $myL.ForeColor="black"
    }
  
}
while ($a -ne "q")

$myF.Close()
