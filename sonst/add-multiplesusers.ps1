
<#PSScriptInfo

.VERSION 2.0

.GUID 84d83480-bdb8-4a46-bcb9-4831e57523f7

.AUTHOR jtutt_000

.COMPANYNAME 

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<# 
 
.DESCRIPTION
   Dieses Script legt Benutzer in einer AD an, als Datenquelle dient eine CSV Datei mit folgenden Einträgen
   Homedrive,Homedirectory,P

#> 

<#
.Synopsis
   Anlegen von AD Benutzern ath,Firstname,Lastname,Password
.EXAMPLE
   Add-ADUsers -tablename users.csv
.EXAMPLE
   Add-ADUsers -tablename users.csv -computername 192.168.12.132
#>
function add-ADUsers
{
    Param
    (
        # Name (Pfad) der CSV-Datei
        [Parameter(Mandatory=$true,
                   Position=0)]
        $csv,

        # Name oder IP des AD Computers, um via Remote Powershell die Benutzer anzulegen
        $computer="127.0.0.1"
    )

    Begin
    {
        $add= {
            Param
            (
                # Hilfebeschreibung zu Param1
                [Parameter(Mandatory=$true,
                           ValueFromPipeline=$true,
                           Position=0)]
                $daten
        
            )
            Begin
            {
            }
            Process
            {
                foreach ($row in $daten) {
                    # Neuen Benutzer Anlegen
                    try {
                        $pw = ConvertTo-SecureString -AsPlainText $row.Password  -Force
                        New-ADUser -Name $row.Lastname -surname $row.Firstname -GivenName $row.Lastname -UserPrincipalName $row.Lastname -Enabled $true -AccountPassword $pw -Path $row.Path  -homedrive $row.HomeDrive -homedirectory $row.Homedirectory
                        Write-Host "Benutzer "($row.Lastname)" erfolgreich angelegt" -ForegroundColor Green
                    }
                    catch {
                        Write-Host "Benutzer "($row.Lastname)" konnte nicht angelegt werden:"$_.Exception.Message -ForegroundColor Red
                    }
                }
                
            }
            End
            {
            }
    
        }
    }
    Process
    {
        $d=Import-Csv $csv
        try {
            Invoke-Command -ComputerName $computer -Credential Administrator -ScriptBlock $add  -ArgumentList $d
        }
        catch {
            Write-Host "Kann ScriptBlock nicht auf Computer "$computer" ausführen" -ForegroundColor Red
        }
    }
    End
    {
    }
}



