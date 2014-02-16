param (
    $email="jtuttas@gmx.net",
    $PSEmailServer = "smtp.mmbbs.de"

)
function GetMailConfig() {
    [xml]$global:config = New-Object -TypeName XML
    $c = Get-Credential -Message "Geben Sie die Zugangsdaten an für $PSEmailServer"
    if ($c.Password.Length -eq 0 -or $c.UserName -eq 0) {
        exit;
    }
            
    $e=$global:config.CreateElement("MailConfig")
    $global:config.AppendChild($e)
    $e=$global:config.CreateElement("user");
    $e.InnerText=$c.UserName
    $global:config.firstChild.AppendChild($e)
    $e=$global:config.CreateElement("password");
    $pw=$c.Password | ConvertFrom-SecureString
    $e.innerText=$pw
    $global:config.firstChild.AppendChild($e)
    $global:config.Save("MailConfig.xml")
}

function createXML() {
    [xml]$x = New-Object -TypeName XML
    $e=$x.createElement("services")
    $d = Get-Date
    $e.SetAttribute("timestamp",$d.Ticks)
    $l=$x.appendChild($e)
    foreach ($service in $s) {
        $e=$x.CreateElement("service")
        $e.InnerText=$service.Name
        $l=$x.firstChild.AppendChild($e)
    }
    $x.Save("services.xml")
}

cls
$msg=""
$s = Get-Service | where {$_.Status -eq "running"}
if (Test-Path "~\services.xml") {
    [xml]$x=Get-Content ~\services.xml
    $d=New-Object System.DateTime($x.services.timestamp)
    Write-Host "Letzte Messung am $d"
    foreach ($service in $x.services.ChildNodes) {
        $n=$service.InnerText
        $ser=Get-Service -Name $n -ErrorAction Ignore
        if ($ser -ne $NULL) {
            if ($ser.Status -eq "running") {
                Write-Host "Der Service $n läuft" -ForegroundColor DarkGreen
            }
            else {
                $s=$ser.Status
                $ms= "Der Service $n lief zum letzten Messzeitpunkt und hat jetzt den Status ($s)"
                $msg += $ms+"`r`n"
                Write-Host WARNING:$ms -ForegroundColor Red

            }
        }
        else {
            $ms= "Der Service $n kann nicht gefunden werden" 
            $msg += $ms+"`r`n"
            Write-Host "WARNUNG:$ms" -ForegroundColor Red
        }

    }

    createXML

    if ($msg.Length -ne 0) {
        [xml]$config = Get-Content "~\MailConfig.xml" -ErrorAction Ignore 
        if ($config -eq $null) {
           $f=getMailConfig
        }
        $pw = $config.MailConfig.password | ConvertTo-SecureString
        $cred = New-Object System.Management.Automation.PSCredential $config.MailConfig.user, $pw
        Write-Host "Sende Wanrmeldung an $email"
        Send-MailMessage -Credential $cred -to $email -from "tuttas@mmbbs.de" -Subject "Services.ps1" -body "$msg" -Port 26 -ErrorVariable err -ErrorAction SilentlyContinue
        if ($err -ne $null) {
            Write-Host "Das Senden der Email ist fehlgeschlagen" -ForegroundColor RED
        }
    }

}
else {
    Write-Host "XML File existiert nicht und wird angelegt"
    createXML
    if (-not (Test-Path "~\MailConfig.xml")) {
        Write-Host "SMTP Zugangsdaten eingeben"
        $f=getMailConfig
    }
}


