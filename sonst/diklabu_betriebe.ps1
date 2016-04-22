<#
    VERBEN:
        find ... findet einen oder mehrere Objekte nach Namen. '%' ist WildCard
        get .... findet ein Objekt durch angabe des PK
        set .... ändert Attribute eines Objektes durch angabe des PK
        new .... erzeugt ein neuen Eintrag
        delete . ein Objekt löschen
#>

<#
.Synopsis
   Sucht einen Betrieb
.DESCRIPTION
   Sucht einen Betrieb nach dessen Namen. % ist Wildcard
.EXAMPLE
   Find-Company -Name "xy gmbh"
#>
function Find-Company
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $name,

        # Adresse des Diklabu Servers
        $uri=$global:server

    )

    Begin
    {
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Get -Uri ($uri+"betriebe/"+$name) -Headers $headers  
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
   Attribute eines Betriebes ändert 
.DESCRIPTION
   Ändert die Attribute eines oder mehrerer Betriebe
.EXAMPLE
   Set-Company -id 1234 -Name "xy gmbh"
.EXAMPLE
   Set-Company -id 1234 -Name "xy gmbh" -plz 16122 -ort Hannover
#>
function Set-Company
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $id,

        # Adresse des Diklabu Servers
        $uri=$global:server,

        #Name des Betriebes
        $name,
        #PLZ des Betriebes
        $plz,
        #Ort des Betriebes
        $ort,
        #Straße des Betriebes
        $strasse,
        #Hausnummer des Betriebes
        $nr

    )

    Begin
    {
        $betrieb=echo "" | Select-Object -Property "NAME","PLZ","ORT","STRASSE","NR"
        $betrieb.NAME=$name
        $betrieb.PLZ=$plz
        $betrieb.ORT=$ort
        $betrieb.STRASSE=$strasse
        $betrieb.NR=$nr
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"betriebe/id/"+$id) -Headers $headers -Body (ConvertTo-Json $betrieb)
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
   Einen Betrieb löschen
.DESCRIPTION
   Löscht einen Betrieb in der Tabelle BETRIEBE 
.EXAMPLE
   Delete-Company -id 1234
.EXAMPLE
   Delete-Company -id 1234 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   1234,5678 | Delete-Company 

#>
function Delete-Company
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        $id,

        # Adresse des Diklabu Servers
        $uri=$global:server
    )

    Begin
    {
    }
    Process
    {
        foreach ($i in $id) {
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Delete -Uri ($uri+"betriebe/"+$i) -Headers $headers 
            return $r;
        }
    }
    End
    {
    }
}

<#
.Synopsis
   Einen Betrieb abfragen
.DESCRIPTION
   FRagt einen Betrieb über seine ID ab
.EXAMPLE
   Get-Company -id 1234
.EXAMPLE
   Get-Company -id 1234 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   1234,5678 | Get-Company 

#>
function Get-Company
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        $id,

        # Adresse des Diklabu Servers
        $uri=$global:server
    )

    Begin
    {
    }
    Process
    {
        foreach ($i in $id) {
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Get -Uri ($uri+"betriebe/id/"+$i) -Headers $headers 
            return $r;
        }
    }
    End
    {
    }
}

<#
.Synopsis
   Einen neuen Betrieb anlegen
.DESCRIPTION
   Erzeugt einen Neuen Betrieb
.EXAMPLE
   New-Company -Name "xy gmbh"
.EXAMPLE
   New-Company -Name "xy gmbh" -plz 16122 -ort Hannover
#>
function New-Company
{
    Param
    (
        # Name des Betriebes
        [Parameter(Mandatory=$true,Position=0)]
        $name,

        # Adresse des Diklabu Servers
        $uri=$global:server,

        #PLZ des Betriebes
        $plz,
        #Ort des Betriebes
        $ort,
        #Straße des Betriebes
        $strasse,
        #Hausnummer des Betriebes
        $nr

    )

    Begin
    {
        $betrieb=echo "" | Select-Object -Property "NAME","PLZ","ORT","STRASSE","NR"
        $betrieb.NAME=$name
        $betrieb.PLZ=$plz
        $betrieb.ORT=$ort
        $betrieb.STRASSE=$strasse
        $betrieb.NR=$nr
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"betriebe/"+$id) -Headers $headers -Body (ConvertTo-Json $betrieb)
        return $r;
    }
    Process
    {
    }
    End
    {
    }
}