﻿<#
    VERBEN:
        find ... findet einen oder mehrere Objekte nach Namen. '%' ist WildCard
        Add .... Etwas hinzufügen
        Remove . ein Objekt entfernen
#>

<#
.Synopsis
   Einen Schüler einer Klasse zuweisen
.DESCRIPTION
   Fügt einen Schüler einer Klasse hinzu
.EXAMPLE
   Add-Coursemember -schuelerid 3623 -klassenid 612 
.EXAMPLE
   Add-Coursemember -schuelerid 3623 -klassenid 612 -uri http://localhost:8080/Diklabu/api/v1/
#>
function Add-Coursemember
{
    Param
    (
        # id des Schülers
        [Parameter(Mandatory=$true,Position=0)]
        $schuelerid,

        # id der Klasse
        [Parameter(Mandatory=$true,Position=1)]
        $klassenid,

        # Adresse des Diklabu Servers
        $uri=$global:server

    )

    Begin
    {
        $rel=echo "" | Select-Object -Property "ID_SCHUELER","ID_KLASSE"
        $rel.ID_SCHUELER=$schuelerid
        $rel.ID_KLASSE=$klassenid
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"klasse/add") -Headers $headers  -Body (ConvertTo-Json $rel)
        return $r;
    }
    Process
    {
    }
    End
    {
    }
}


<#
.Synopsis
   Schüler einer Klasse abfragen
.DESCRIPTION
   Liefert die Schülerobjekte einer Klasse
.EXAMPLE
   Find-Coursemember  -kname FISI13A 
.EXAMPLE
   Find-Coursemember  -kname FISI13% -uri http://localhost:8080/Diklabu/api/v1/
#>
function Find-Coursemember
{
    Param
    (
        # Name der Klasse
        [Parameter(Mandatory=$true,Position=0)]
        $kname,

        # Adresse des Diklabu Servers
        $uri=$global:server

    )

    Begin
    {
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Get -Uri ($uri+"klasse/"+$kname) -Headers $headers  

        return  $r;
    }
    Process
    {
    }
    End
    {
    }
}


<#
.Synopsis
   Einen Schüler aus ener Klasse entfernen
.DESCRIPTION
   Löscht eine Schüler mit der schuelerid aus der Klasse mit der klassenid
.EXAMPLE
   delete-coursemember -schuelerid 1234 -klassenid 1234
.EXAMPLE
   delete-coursemember -schuelerid 1234 -klassenid 1234 -uri http://localhost:8080/Diklabu/api/v1/
#>
function Remove-Coursemember
{
    Param
    (
        # ID des Schuelers
        [Parameter(Mandatory=$true,Position=0)]
        $schuelerid,
        # ID der klasse
        [Parameter(Mandatory=$true,Position=1)]
        $klassenid,

        # Adresse des Diklabu Servers
        $uri=$global:server
    )

    Begin
    {
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Delete -Uri ($uri+"klasse/"+$schuelerid+"/"+$klassenid) -Headers $headers 
        return $r;
    }
    Process
    {
    }
    End
    {
    }
}

#Export-ModuleMember -Function Add-Coursemember
#Export-ModuleMember -Function Find-Coursemember
#Export-ModuleMember -Function Remove-Coursemember