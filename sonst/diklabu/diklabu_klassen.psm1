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
   Eine Klasse(n) abfragen. % ist Wildcard
.DESCRIPTION
   Fragt die Tabelle Klassen ab und gibt die Klasse zurück wenn diese existiert
.EXAMPLE
   Find-Course -kname "FISI13A"
.EXAMPLE
   Find-Course -kname "FISI13%" 
.EXAMPLE
   Find-Course -kname "FISI13A" -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   "FISI13%","FIAE13%" | Find-Course -uri http://localhost:8080/Diklabu/api/v1/

#>
function Find-Course
{
    Param
    (
        # Name der Klasse
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        $kname,

        # Adresse des Diklabu Servers
        $uri=$global:server

    )

    Begin
    {
    }
    Process
    {
        foreach ($n in $kname) {
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Get -Uri ($uri+"klasse/info/"+$n) -Headers $headers  
            return $r;
        }

    }
    End
    {
    }
}

<#
.Synopsis
   Attribute einer Klasse ändern
.DESCRIPTION
   Ändert die Attribute einer Klasse 
.EXAMPLE
   Set-Course -id 1245 -kname FISI13A 
.EXAMPLE
   Set-Course -id 1234 -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   Set-Course -id 1234 -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/ -titel "Eine Klasse"
.EXAMPLE
   Set-Course -id 1244 -uri http://localhost:8080/Diklabu/api/v1/ -idlehrer TU
.EXAMPLE
   Set-Course -id 2124 -uri http://localhost:8080/Diklabu/api/v1/ -idkategorie 17
.EXAMPLE
   Set-Course -id 3456 -uri http://localhost:8080/Diklabu/api/v1/ -termine Block_blau
.EXAMPLE
   1234,5678,9876| Set-Course -uri http://localhost:8080/Diklabu/api/v1/ -termine Block_blau

#>
function Set-Course
{
    Param
    (
        # ID der Klasse
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        $id,

        # Adresse des Diklabu Servers
        $uri=$global:server,

        # Name der Klasse
        $kname,

        # Kürzel (fk) des Klassenlehrers        
        $idlehrer,

        # Titel der Klasse
        $titel,

        # Notiz zur Klasse
        $notiz,

        # Termine
        $termine,

        # ID_Kategorie
        $idkategorie

    )

    Begin
    {
       
    }
    Process
    {
     foreach ($i in $id) {
            $klasse=echo "" | Select-Object -Property "ID_LEHRER","KNAME","TITEL","NOTIZ","TERMINE","ID_KATEGORIE"
            $klasse.ID_LEHRER=$idlehrer
            $klasse.KNAME=$kname
            $klasse.TITEL=$titel
            $klasse.NOTIZ=$notiz
            $klasse.TERMINE=$termine
            $klasse.ID_KATEGORIE=$idkategorie
            $headers=@{}
            $headers["content-Type"]="application/json;charset=iso-8859-1"
            $headers["auth_token"]=$global:auth_token;
            $r=Invoke-RestMethod -Method Post -Uri ($uri+"klasse/admin/id/"+$i) -Headers $headers  -Body (ConvertTo-Json $klasse)
            return $r;
        }
    }
    End
    {
    }
}

<#
.Synopsis
   Eine Klasse abfragen
.DESCRIPTION
   Attribute einer Klasse abfragen
.EXAMPLE
   Get-Course -id 1245 
.EXAMPLE
   Get-Course -id 1234 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   1234,5678,9876| Get-Course 

#>
function Get-Course
{
    Param
    (
        # ID der Klasse
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
            $r=Invoke-RestMethod -Method Get -Uri ($uri+"klasse/id/"+$i) -Headers $headers 
            return $r;
        }
    }
    End
    {
    }
}

<#
.Synopsis
   Eine neue Klasse anlegen
.DESCRIPTION
   Legt eine Neue Klasse mit den Attributen an
.EXAMPLE
   New-Course -kname FISI13A 
.EXAMPLE
   New-Course -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   New-Course -kname FISI14A -uri http://localhost:8080/Diklabu/api/v1/ -idlehrer TU

#>
function New-Course
{
    Param
    (
        # Name der Klasse
        [Parameter(Mandatory=$true,Position=0)]
        $name,

        # Adresse des Diklabu Servers
        $uri=$global:server,


        # Kürzel (fk) des Klassenlehrers        
        $idlehrer,

        # Titel der Klasse
        $titel,

        # Notiz zur Klasse
        $notiz,

        # Termine
        $termine,

        # ID_Kategorie
        $idkategorie

    )

    Begin
    {
        $klasse=echo "" | Select-Object -Property "ID_LEHRER","KNAME","TITEL","NOTIZ","TERMINE","ID_KATEGORIE"
        $klasse.ID_LEHRER=$idlehrer
        $klasse.KNAME=$name
        $klasse.TITEL=$titel
        $klasse.NOTIZ=$notiz
        $klasse.TERMINE=$termine
        $klasse.ID_KATEGORIE=$idkategorie
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$global:auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"klasse/admin/") -Headers $headers  -Body (ConvertTo-Json $klasse)
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
   Eine Klasse löschen
.DESCRIPTION
   Löscht eine Klasse in der Tabelle KLASSE
.EXAMPLE
   Delete-Course -id 1234
.EXAMPLE
   Delete-Course -id 1234 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   1234,5678| Delete-Course 

#>
function Delete-Course
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
            $r=Invoke-RestMethod -Method Delete -Uri ($uri+"klasse/admin/"+$id) -Headers $headers 
            return $r;
        }
    }
    End
    {
    }
}

