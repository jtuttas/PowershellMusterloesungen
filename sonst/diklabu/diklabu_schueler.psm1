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
   Informationen zu einem Schüler abfragen
.DESCRIPTION
   Informationen zu einem Schüler abfragen
.EXAMPLE
   Find-Pupil -vname Joerg -nname Tuttas -geb 1968-04-11
.EXAMPLE
   Find-Pupil -vname Joerg -nname Tuttas -geb 1968-04-11 -uri http://localhost:8080/Diklabu/api/v1/
#>
function Find-Pupil
{
    Param
    (       

        # Vorname des Schülers
        [Parameter(Mandatory=$true,Position=0)]
        $vname,

        # Nachname des Schülers
        [Parameter(Mandatory=$true,Position=1)]
        $nname,

        # Geburtsdatum im SQL Format yyyy-mm-dd
        [Parameter(Mandatory=$true,Position=2)]
        $geb,

        # Adresse des Diklabu Servers
        [Parameter(Position=4)]
        $uri=$global:server

    )

    Begin
    {
        $data=echo "" | Select-Object -Property "gebDatum","name","vorName"
        $data.gebDatum=$geb
        $data.name=$nname
        $data.vorName=$vname
        $headers=@{}
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"schueler/info") -Headers $headers -Body (ConvertTo-Json $data)  -ContentType "application/json; charset=iso-8859-1"     
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
   Einem Schüler abfragen
.DESCRIPTION
   Einem Schüler abfragen
.EXAMPLE
   Get-Pupil -id 1234
.EXAMPLE
   Get-Pupil -id 1234 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   1234,5678 | Get-Pupil 

#>
function Get-Pupil
{
    Param
    (       
        # ID des Schülers
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
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Get -Uri ($uri+"schueler/"+$i) -Headers $headers -ContentType "application/json; charset=iso-8859-1"     
            return $r;
        }

    }
    End
    {
    }
}

<#
.Synopsis
   Einen Schüler hinzufügen
.DESCRIPTION
   Fügt einen Schüler zur Tabelle Schueler hinzu
.EXAMPLE
   New-Pupil -vname Joerg -nname Tuttas -geb 1968-04-11
.EXAMPLE
   New-Pupil -vname Joerg -nname Tuttas -geb 1968-04-11 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   New-Pupil -vname Jörg -nname Tuttas -geb 1968-04-11 -email jtuttas@gmx.net -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   New-Pupil -vname Joerg -nname Tuttas -geb 1968-04-11 -uri http://localhost:8080/Diklabu/api/v1/ -idausbilder=4711
#>
function New-Pupil
{
    Param
    (
        # Vorname des Schülers
        [Parameter(Mandatory=$true,Position=0)]
        $vname,

        # Nachname des Schülers
        [Parameter(Mandatory=$true,Position=1)]
        $nname,

        # Geburtsdatum im SQL Format yyyy-mm-dd
        [Parameter(Mandatory=$true,Position=2)]
        $geb,

        # Adresse des Diklabu Servers
        $uri=$global:server,

        # EMail Adresse des Schülers
        $email,

        # ID Des Ausbilders
        $idausbilder,

        # Abgang
        $abgang="N",

        # Info
        $info

    )

    Begin
    {
        $schueler=echo "" | Select-Object -Property "EMAIL","GEBDAT","VNAME","NNAME","ID_AUSBILDER","ABGANG","INFO"
        $schueler.VNAME=$vname
        $schueler.NNAME=$nname
        $schueler.GEBDAT=$geb
        $schueler.EMAIL=$email
        $schueler.ID_AUSBILDER=$idausbilder
        $schueler.ABGANG=$abgang
        $schueler.INFO=$info
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"schueler/admin") -Headers $headers -Body (ConvertTo-Json $schueler)
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
   Attribute eines Schülers ändern
.DESCRIPTION
   Ändert Attribute eines Schülers
.EXAMPLE
   Set-Pupil -id 1234 -vname Joerg -nname Tuttas -geb 1968-04-11
.EXAMPLE
   Set-Pupil -id 1234 -vname Joerg -nname Tuttas -geb 1968-04-11 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   Set-Pupil -id 1234 -vname Jörg -nname Tuttas -geb 1968-04-11 -email jtuttas@gmx.net -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   Set-Pupil -id 1234 -vname Joerg -nname Tuttas -geb 1968-04-11 -uri http://localhost:8080/Diklabu/api/v1/ -idausbilder=4711
.EXAMPLE
   1234,5678 | Set-Pupil -abgang "J"

#>
function Set-Pupil
{
    Param
    (
        # ID des Schülers
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        $id,

        # Vorname des Schülers
        $vname,

        # Nachname des Schülers
        $nname,

        # Geburtsdatum im SQL Format yyyy-mm-dd
        $geb,

        # Adresse des Diklabu Servers
        $uri=$global:server,

        # EMail Adresse des Schülers
        $email,

        # ID Des Ausbilders
        $idausbilder,

        # Abgang
        $abgang,

        # Info
        $info

    )

    Begin
    {
        
    }
    Process
    {
        foreach ($i in $id) {
            $schueler=echo "" | Select-Object -Property "EMAIL","GEBDAT","VNAME","NNAME","ID_AUSBILDER","ABGANG","INFO"
            $schueler.VNAME=$vname
            $schueler.NNAME=$nname
            $schueler.GEBDAT=$geb
            $schueler.EMAIL=$email
            $schueler.ID_AUSBILDER=$idausbilder
            $schueler.ABGANG=$abgang
            $schueler.INFO=$info
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Post -Uri ($uri+"schueler/admin/"+$i) -Headers $headers -Body (ConvertTo-Json $schueler)
            return $r;
        }
    }
    End
    {
    }
}


<#
.Synopsis
   Einen Schüler löschen
.DESCRIPTION
   Entfernt einen Schüler aus der Tabelle Schüler, sofern er nicht noch in Klassenb zugeordnet ist
.EXAMPLE
   Delete-Pupil -id 1234 
.EXAMPLE
   Delete-Pupil -id 1234 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   1234,5678 | Delete-Pupil 

#>
function Delete-Pupil
{
    Param
    (
        # ID des Schülers
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
            $r=Invoke-RestMethod -Method Delete -Uri ($uri+"schueler/admin/"+$i) -Headers $headers 
            return $r;
        }
    }
    End
    {
    }
}


