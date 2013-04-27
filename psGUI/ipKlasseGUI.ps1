function ipclass ([string]$ip) {
    [array]$x = $ip.Split(".")
    if($x[0] -le 127)
    {
        return "A";
    }
    if($x[0] -gt 127 -and $x[0] -le 191)
    {
        return "B";
    }
    if($x[0] -gt 191 -and $x[0] -le 223)
    {
        Return "C"
    }
}
 
function validip($ip) {
    $aip = $ip.split(".")
    if ($aip.Length -ne 4) {
        Write-Host ("1")
        return $flase;
    }
    foreach ($oktett in $aip) {
        if ($oktett -le 0 -or $oktett -gt 255) {
            Write-Host ("2 "+$oktett)
            return $flase
        }
    }
    return $true;
}
 
$myForm = New-Object System.Windows.Forms.Form
$tf = New-Object System.Windows.Forms.TextBox
$l = New-Object System.Windows.Forms.Label
$tf.Location="30,10";
$tf.Text="0.0.0.0"
$l.Location="30,50";
$l.Width=280
$l.Text="?"
$tf.add_KeyDown({
    if ($_.KeyCode -eq "Return") {
        $ip = $tf.Text
        if (validip($ip)) {
            $c = ipclass($tf.Text)
            $l.Text="Es Handelt sich um ein Klasse "+$c+" Netz"
        }
        else {
            $l.Text="Es Handelt sich um keine gültige IP Adresse"
        }
    }
    else {
        $l.Text=""
    }
})
$myForm.Size="330,150"
$myForm.Controls.add($tf)
$myForm.Controls.add($l)
$myForm.Text="IP Klassenrechner"
$myForm.ShowDialog();