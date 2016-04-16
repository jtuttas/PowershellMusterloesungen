<#
.Synopsis
   Anmelden am Klassenbuch
.DESCRIPTION
   Anmleden beim Klassenbuch und Sessionkey beziehen
.EXAMPLE
   login-diklabu -user Benutzername -password password 
.EXAMPLE
   login-diklabu -user Benutzername -password password -URI http://localhost:8080/Diklabu/api/v1/
#>
function login-diklabu
{
    Param
    (
        # Benutzername
        [Parameter(Mandatory=$true,Position=0)]
        $user,

        # Kennwort
        [Parameter(Mandatory=$true,Position=1)]
        $password,

        # URI des Diklabu Servers
        [Parameter(Position=2)]
        $uri="http://localhost:8080/Diklabu/api/v1/"

    )

    Begin
    {
        $data=echo "" | Select-Object -Property "benutzer","kennwort"
        $data.benutzer=$user
        $data.kennwort=$password        
        $headers=@{}
        $headers["content-Type"]="application/json"
        $headers["service_key"]="TUf80ebc87-ad5c-4b29-9366-5359768df5a1";
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"auth/login") -Headers $headers -Body (ConvertTo-Json $data)
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
   Informationen zu einem Schüler abfragen
.DESCRIPTION
   Informationen zu einem Schüler abfragen
.EXAMPLE
   get-pupil -auth_token agfdasfdg -vname Joerg -nname Tuttas -geb 1968-04-11
.EXAMPLE
   get-pupil -auth_token agfdasfdg -vname Joerg -nname Tuttas -geb 1968-04-11 -uri http://localhost:8080/Diklabu/api/v1/
#>
function get-pupil
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $auth_token,

        # Vorname des Schülers
        [Parameter(Mandatory=$true,Position=1)]
        $vname,

        # Nachname des Schülers
        [Parameter(Mandatory=$true,Position=2)]
        $nname,

        # Geburtsdatum im SQL Format yyyy-mm-dd
        [Parameter(Mandatory=$true,Position=3)]
        $geb,

        # Adresse des Diklabu Servers
        [Parameter(Position=4)]
        $uri="http://localhost:8080/Diklabu/api/v1/"

    )

    Begin
    {
        $data=echo "" | Select-Object -Property "gebDatum","name","vorName"
        $data.gebDatum=$geb
        $data.name=$nname
        $data.vorName=$vname
        $headers=@{}
        $headers["content-Type"]="application/json"
        $headers["auth_token"]=$auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"schueler/info") -Headers $headers -Body (ConvertTo-Json $data)         
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
   Einen Schüler hinzufügen
.DESCRIPTION
   Fügt einen Schüler zur Tabelle Schueler hinzu
.EXAMPLE
   add-pupil -auth_token agfdasfdg -vname Joerg -nname Tuttas -geb 1968-04-11
.EXAMPLE
   add-pupil -auth_token agfdasfdg -vname Joerg -nname Tuttas -geb 1968-04-11 -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   add-pupil -auth_token agfdasfdg -vname Jörg -nname Tuttas -geb 1968-04-11 -email jtuttas@gmx.net -uri http://localhost:8080/Diklabu/api/v1/

#>
function add-pupil
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $auth_token,

        # Vorname des Schülers
        [Parameter(Mandatory=$true,Position=1)]
        $vname,

        # Nachname des Schülers
        [Parameter(Mandatory=$true,Position=2)]
        $nname,

        # Geburtsdatum im SQL Format yyyy-mm-dd
        [Parameter(Mandatory=$true,Position=3)]
        $geb,

        # Adresse des Diklabu Servers
        [Parameter(Position=4)]
        $uri="http://localhost:8080/Diklabu/api/v1/",

        # EMail Adresse des Schülers
        $email,

        # ID Des Ausbilders
        $idausbilder

    )

    Begin
    {
        $schueler=echo "" | Select-Object -Property "EMAIL","GEBDAT","VNAME","NNAME","ID_AUSBILDER","ABGANG"
        $schueler.VNAME=$vname
        $schueler.NNAME=$nname
        $schueler.GEBDAT=$geb
        $schueler.EMAIL=$email
        $schueler.ID_AUSBILDER=$idausbilder
        $schueler.ABGANG="N"
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"schueler") -Headers $headers -Body (ConvertTo-Json $schueler)
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
   Eine Klasse abfragen
.DESCRIPTION
   Fragt die Tabelle Klassen ab und gibt die Klasse zurück wenn diese existiert
.EXAMPLE
   get-course -auth_token agfdasfdg -kname FISI13A 
.EXAMPLE
   get-course -auth_token agfdasfdg -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/
#>
function get-course
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $auth_token,

        # Name der Klasse
        [Parameter(Mandatory=$true,Position=1)]
        $kname,

        # Adresse des Diklabu Servers
        [Parameter(Position=2)]
        $uri="http://localhost:8080/Diklabu/api/v1/"

    )

    Begin
    {
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$auth_token;
        $r=Invoke-RestMethod -Method Get -Uri ($uri+"klasse/info/"+$kname) -Headers $headers  
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
   Einen Schüler einer Klasse zuweisen
.DESCRIPTION
   Fügt einen Schüler einer Klasse hinzu
.EXAMPLE
   addto-course -auth_token agfdasfdg -schuelerid 3623 -klassenid 612 
.EXAMPLE
   addto-course -auth_token agfdasfdg -schuelerid 3623 -klassenid 612 -uri http://localhost:8080/Diklabu/api/v1/
#>
function addto-course
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $auth_token,

        # id des Schülers
        [Parameter(Mandatory=$true,Position=1)]
        $schuelerid,

        # id der Klasse
        [Parameter(Mandatory=$true,Position=2)]
        $klassenid,

        # Adresse des Diklabu Servers
        [Parameter(Position=3)]
        $uri="http://localhost:8080/Diklabu/api/v1/"

    )

    Begin
    {
        $rel=echo "" | Select-Object -Property "ID_SCHUELER","ID_KLASSE"
        $rel.ID_SCHUELER=$schuelerid
        $rel.ID_KLASSE=$klassenid
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$auth_token;
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
   Eine Klasse hinzufügen
.DESCRIPTION
   Fügt eine Klasse der Tabelle Klasse hinzu
.EXAMPLE
   add-course -auth_token agfdasfdg -kname FISI13A 
.EXAMPLE
   add-course -auth_token agfdasfdg -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/
.EXAMPLE
   add-course -auth_token agfdasfdg -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/ -titel Eine Klasse
.EXAMPLE
   add-course -auth_token agfdasfdg -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/ -idlehrer TU
#>
function add-course
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $auth_token,

        # Name der Klasse
        [Parameter(Mandatory=$true,Position=1)]
        $kname,

        # Adresse des Diklabu Servers
        [Parameter(Position=2)]
        $uri="http://localhost:8080/Diklabu/api/v1/",

        # Kürzel (fk) des Klassenlehrers        
        $idlehrer,

        # Titel der Klasse
        $titel,

        # Notiz zur Klasse
        $notiz

    )

    Begin
    {
        $klasse=echo "" | Select-Object -Property "ID_LEHRER","KNAME","TITEL","NOTIZ"
        $klasse.ID_LEHRER=$idlehrer
        $klasse.KNAME=$kname
        $klasse.TITEL=$titel
        $klasse.NOTIZ=$notiz
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$auth_token;
        $r=Invoke-RestMethod -Method Post -Uri ($uri+"klasse/") -Headers $headers  -Body (ConvertTo-Json $klasse)
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
   get-coursemember -auth_token agfdasfdg -kname FISI13A 
.EXAMPLE
   get-coursemember -auth_token agfdasfdg -kname FISI13A -uri http://localhost:8080/Diklabu/api/v1/
#>
function get-coursemember
{
    Param
    (
        # Auth Token (nach Login)
        [Parameter(Mandatory=$true,Position=0)]
        $auth_token,

        # Name der Klasse
        [Parameter(Mandatory=$true,Position=1)]
        $kname,

        # Adresse des Diklabu Servers
        [Parameter(Position=2)]
        $uri="http://localhost:8080/Diklabu/api/v1/"

    )

    Begin
    {
        $headers=@{}
        $headers["content-Type"]="application/json;charset=iso-8859-1"
        $headers["auth_token"]=$auth_token;
        $r=Invoke-RestMethod -Method Get -Uri ($uri+"klasse/"+$kname) -Headers $headers  
        return $r;
    }
    Process
    {
    }
    End
    {
    }
}

