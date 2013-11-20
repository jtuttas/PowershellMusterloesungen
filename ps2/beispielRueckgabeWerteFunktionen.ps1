function returnAValue ([Int32]$takeMe)
{
 $returnThisValue=$takeMe

 $returnThisValue #der Wert dieser Variablen wird nun an den aufrufenden Prozess zurückgegeben
}

function returnMoreThanOneValue ([Int32]$takeMeAgain)
{#oder so: Rückgabe mehrerer Werte
 $returnThisValue=$takeMeAgain  #Erster Rückgabewert
 $returnThatValue=$takeMeAgain - 21  #Zweiten Rückgabewert verändern

 $returnThisValue #1. Rückgabe
 $returnThatValue #2. Rückgabe
}

cls
$Igot = returnAValue 55
Write-host "I got $Igot"

$Igot = returnMoreThanOneValue 42
Write-host "I got more: $Igot"

#Gespeichert werden alle Rückgabewerte in einem Array:
$Igot[0]
$Igot[1]
