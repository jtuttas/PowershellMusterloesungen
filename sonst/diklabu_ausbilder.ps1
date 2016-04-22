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
   Einen Ausbilder suchen
.DESCRIPTION
   Liefert eine Liste von passenden Ausbilder Objekten zurück
.EXAMPLE
   Find-Instructor -name "%Meyer"
.EXAMPLE
   Find-Instructor -name "%Meyer" -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   "%Schmidt","%Meyer" | Find-Instructor
#>
function Find-Instructor
{
    Param
    (
        # Name des Ausbilders
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        $name,

        # Adresse des Diklabu Servers
        $uri=$global:server

    )

    Begin
    {
    }
    Process
    {
        foreach ($n in $name) {
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Get -Uri ($uri+"ausbilder/find/"+$n) -Headers $headers  
            return $r;
        }

    }
    End
    {
    }
}

<#
.Synopsis
   Einen Ausbilder abfragen
.DESCRIPTION
   Liefert den Ausbilder zur id zurück
.EXAMPLE
   Get-Instructor -ausbilderId 1234
.EXAMPLE
   Get-Instructor -ausbilderId 1234 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   1234,5678 | Get-Instructor
#>
function Get-Instructor
{
    Param
    (
        # ID des Ausbilders
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        $ausbilderId,

        # Adresse des Diklabu Servers
        $uri=$global:server

    )

    Begin
    {
    }
    Process
    {
        foreach ($id in $ausbilderId) {
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Get -Uri ($uri+"ausbilder/"+$id) -Headers $headers  
            return $r;
        }

    }
    End
    {
    }
}


<#
.Synopsis
   Attribute eines Ausbilders ändern
.DESCRIPTION
   Ändert diverse Attribute eines Ausbilders
.EXAMPLE
   Set-Instructor -ausbilderId 123 -Name "Herr Schmidt"
.EXAMPLE
   Set-Instructor -ausbilderId 123 -tel 110 -fax 112
.EXAMPLE
  1234,4567|Set-Instructor -tel 110 -fax 112
#>
function Set-Instructor
{
    Param
    (
        # Id des Ausbilders
        [Parameter(Mandatory=$true,ValueFromPipeline,Position=0)]
        $ausbilderId,

        # Adresse des Diklabu Servers
        $uri=$global:server,

        #Name
        $name,

        #Anrede des Ausbilders
        $anrede,
        # EMAIL des Ausbilders
        $email,
        #FAX Nummer des Asubilders
        $fax,
        #Tel Nummer des Asubilders
        $tel,
        #ID_Betrieb des Ausbilders
        $id_betrieb

    )

    Begin
    {
        
    }
    Process
    {
        foreach ($id in $ausbilderId) {
            $ausbilder=echo "" | Select-Object -Property "NNAME","ANREDE","EMAIL","FAX","ID_BETRIEB","TELEFON"
            $ausbilder.ANREDE=$anrede
            $ausbilder.EMAIL=$email
            $ausbilder.FAX=$fax
            $ausbilder.ID_BETRIEB=$id_betrieb
            $ausbilder.TELEFON=$tel
            $ausbilder.NNAME=$name       
        
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Post -Uri ($uri+"ausbilder/"+$id) -Headers $headers -Body (ConvertTo-Json $ausbilder)
            return $r;
        }
    }
    End
    {
    }
}

<#
.Synopsis
   Legt einen neuen Ausbilder an
.DESCRIPTION
   Erzeugt einen neuen Ausbilder
.EXAMPLE
   New-Instructor -Name "Herr Schmidt"
.EXAMPLE
   New-Instructor -Name "Herr Meyer" -tel 110 -fax 112 -email test@test.de
#>
function New-Instructor
{
    Param
    (
        # Name des Ausbilders
        [Parameter(Mandatory=$true,Position=0)]
        $name,

        # Adresse des Diklabu Servers
        $uri=$global:server,

        #Anrede des Ausbilders
        $anrede,
        # EMAIL des Ausbilders
        $email,
        #FAX Nummer des Asubilders
        $fax,
        #Tel Nummer des Asubilders
        $tel,
        #ID_Betrieb des Ausbilders
        $id_betrieb

    )

    Begin
    {
            $ausbilder=echo "" | Select-Object -Property "NNAME","ANREDE","EMAIL","FAX","ID_BETRIEB","TELEFON"
            $ausbilder.ANREDE=$anrede
            $ausbilder.EMAIL=$email
            $ausbilder.FAX=$fax
            $ausbilder.ID_BETRIEB=$id_betrieb
            $ausbilder.TELEFON=$tel
            $ausbilder.NNAME=$name       
        
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Post -Uri ($uri+"ausbilder/") -Headers $headers -Body (ConvertTo-Json $ausbilder)
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
   Einen Ausbilder löschen
.DESCRIPTION
   Löscht einen Ausbilder
.EXAMPLE
   Delete-Instructor -ausbilderId 123 
.EXAMPLE
   Delete-Instructor -ausbilderId 123 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
  1234,4567|Delete-Instructor 
#>
function Delete-Instructor
{
    Param
    (
        # Id des Ausbilders
        [Parameter(Mandatory=$true,ValueFromPipeline,Position=0)]
        $ausbilderId,

        # Adresse des Diklabu Servers
        $uri=$global:server
    )

    Begin
    {
        
    }
    Process
    {
        foreach ($id in $ausbilderId) {        
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Delete -Uri ($uri+"ausbilder/"+$id) -Headers $headers 
            return $r;
        }
    }
    End
    {
    }
}
