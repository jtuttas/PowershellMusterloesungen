<#
.Synopsis
   Anlegen von AD Benutzern und Gruppen
.DESCRIPTION
   Dieses Script legt Gruppen an und weist diesen dann Gruppen zu, als Datenquelle dient eine CSV Datei mit folgenden Einträgen
   Fistname,LastName, group
.EXAMPLE
   Add-ADUsers -tablename users.csv
.EXAMPLE
   Add-ADUsers -tablename users.csv -computername 192.168.12.132
.EXAMPLE
   Add-ADUsers -tablename users.csv -computername 192.168.12.132 -defaultPassword Tuttas1!
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
        $computer="127.0.0.1",
        # default Kennwort (ansonsten ist es Test1!Test1!)
        $passwd="Test1!Test1!"
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
                $daten,

                [Parameter(Mandatory=$true,
                Position=1)]
                $pwdtxt

            )
            Begin
            {
            }
            Process
            {
                $groups=@{}
                foreach ($row in $daten) {
                    if ($groups[$row.group] -eq $null) {
                        # Neue Gruppe Anlegen
                        $groups[$row.group]=$row.group
                        try {
                            New-ADGroup -Name $row.group -GroupScope Global
                            Write-Host "Neue Gruppe "($row.group)" angelegt" -ForegroundColor Green
                        }
                        catch {
                            write-host "Gruppe "($row.group)" konnte nicht angelegt werden" -ForegroundColor Red
                        }
                    }
                    # Neuen Benutzer Anlegen
                    try {
                        $pw = ConvertTo-SecureString -AsPlainText $pwdtxt  -Force
                        New-ADUser -Name $row.Lastname -surname $row.Firstname -GivenName $row.lastname -UserPrincipalName $row.lastname -Enabled $true -AccountPassword $pw                
                    }
                    catch {
                        Write-Host "Benutzer "($row.lastname)" konnte nicht angelegt werden" -ForegroundColor Red
                    }
                    try {
                        # Neuen Benutzer in die Gruppe eintragen
                        Add-ADGroupMember -Identity $row.group -Members $row.lastname
                        Write-Host "Benutzer "($row.lastname)" zur Gruppe "($row.group)" zugeordnet" -ForegroundColor Green

                    }
                    catch {
                        Write-Host "Benutzer "($row.lastname)" konnte nicht zur Gruppe "($row.group)" zugeordnet werden" -ForegroundColor Red
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
            Invoke-Command -ComputerName $computer -Credential Administrator -ScriptBlock $add  -ArgumentList $d,$passwd
        }
        catch {
            Write-Host "Kann ScriptBlock nicht auf Computer "$computer" ausführen" -ForegroundColor Red
        }
    }
    End
    {
    }
}

