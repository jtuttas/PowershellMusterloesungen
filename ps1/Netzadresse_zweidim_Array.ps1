$rechnerliste = (("NAS",192,168,178,1),("Desktop PC1",192,168,178,19),("Desktop PC2",192,168,178,22),("Drucker",192,168,118,22),("WebServer",192,168,118,9),("Fileserver",192,168,118,56))
$sub1= Read-Host ("1. Oktett Subnetzmaske") 
$sub2=Read-Host ("2. Oktett Subnetzmaske") 
$sub3=Read-Host ("3. Oktett Subnetzmaske")
$sub4=Read-Host ("4. Oktett Subnetzmaske")
$n1=$rechnerliste[0][1] -band $sub1
$n2=$rechnerliste[0][2] -band $sub2
$n3=$rechnerliste[0][3] -band $sub3
$n4=$rechnerliste[0][4] -band $sub4
Write-Host ("Netz Adresse von "+$rechnerliste[0][0]+" ist $n1.$n2.$n3.$n4")
$n1=$rechnerliste[1][1] -band $sub1
$n2=$rechnerliste[1][2] -band $sub2
$n3=$rechnerliste[1][3] -band $sub3
$n4=$rechnerliste[1][4] -band $sub4
Write-Host ("Netz Adresse von "+$rechnerliste[1][0]+" ist $n1.$n2.$n3.$n4")
$n1=$rechnerliste[2][1] -band $sub1
$n2=$rechnerliste[2][2] -band $sub2
$n3=$rechnerliste[2][3] -band $sub3
$n4=$rechnerliste[2][4] -band $sub4
Write-Host ("Netz Adresse von "+$rechnerliste[2][0]+" ist $n1.$n2.$n3.$n4")
$n1=$rechnerliste[3][1] -band $sub1
$n2=$rechnerliste[3][2] -band $sub2
$n3=$rechnerliste[3][3] -band $sub3
$n4=$rechnerliste[3][4] -band $sub4
Write-Host ("Netz Adresse von "+$rechnerliste[3][0]+" ist $n1.$n2.$n3.$n4")
$n1=$rechnerliste[4][1] -band $sub1
$n2=$rechnerliste[4][2] -band $sub2
$n3=$rechnerliste[4][3] -band $sub3
$n4=$rechnerliste[4][4] -band $sub4
Write-Host ("Netz Adresse von "+$rechnerliste[4][0]+" ist $n1.$n2.$n3.$n4")
$n1=$rechnerliste[5][1] -band $sub1
$n2=$rechnerliste[5][2] -band $sub2
$n3=$rechnerliste[5][3] -band $sub3
$n4=$rechnerliste[5][4] -band $sub4
Write-Host ("Netz Adresse von "+$rechnerliste[5][0]+" ist $n1.$n2.$n3.$n4")
