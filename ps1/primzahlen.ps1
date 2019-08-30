#Option 1

$input1=Read-Host "Please input a number"
for ($i=2; $i-le $input1; $i++) {
    $found=$true;
    for ($j=2; $j -lt $i; $j++) {
        if (($i % $j) -eq 0) {
            $found = $false;
            break;
        }
    }
    if ($found) {
        Write-Host $i;
    }
}


#Option 2

$input1=Read-Host "Please input a number"
for ($i=2; $i-le $input1; $i++) {
    $found=$true;
    for ($j=2; $j -lt $i; $j++) {
        if (([int]($i/$j))*$j -eq $i) {
            $found = $false;
            break;
        }
    }
    if ($found) {
        Write-Host $i;
    }
}


#Option 3

$input1=Read-Host "Please input a number"
for ($i=2; $i-le $input1; $i++) {
    $found=$true;
    for ($j=2; $j -lt $i; $j++) {
        if (($i/$j) -is [int]) {
            $found = $false;
            break;
        }
    }
    if ($found) {
        Write-Host $i;
    }
}

# Option 4

cls
# Primzahlen bestimmung mit der Powershell
$n=0;
$t=0;
for ($i=2;$i -le 1000;$i=$i+1) {
	for ($j=2;$j -lt $i;$j=$j+1) {
		$t=$i/$j
		#Write-Host ("Teste $i durch $j das ergebnis ist $t der Type ist "+$t.GetType().Name)
		$s=$t.GetType().Name
		if ($s -match "int32") {
			$j=2000
		}
	}
	if ($j -ne 2001) {
		Write-Host ("Die Zahl $i ist eine Primzahl")
		$n=$n+1
	}
}
Write-Host ("Es existieren $n Primzahlen!")
