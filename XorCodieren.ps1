
param(
[String]$s
)
cls
[String]$o=""
$s=$s.ToLower();
for ($i=0;$i -lt $s.length;$i++) {
		$z=[byte]$s.chars($i)
		$z=$z -bxor 16
		$o=$o+[char]$z
}
Write-Host ("$o")
