<#
.Synopsis
   Ein Module was Hallo sagt
.DESCRIPTION
   Dieses Modul sagt zu jedem Objekt in der Pipeline Hallo
.EXAMPLE
   "Thomas" | Say-Hello
.EXAMPLE
   get-childitems | Say-Hello
#>
function say-Hello
{
    [OutputType([String])]
    Param
    (
        # Der Parameter zu dem das Wort Hallo vorangestellt werden soll
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        $name,

        # Die Fordergrundfarbe in der der Text ausgegeben wedren soll
        $color="white"

    )

    Begin
    {
        Write-Host "Wir starten"
    }
    Process
    {
        Write-Host "Hello $name" -ForegroundColor $color
    }
    End
    {
        Write-Host "Wir sind fertig"
    }
}

<#
.Synopsis
   Ein Module was jeder Zeichenkette eine fortlaufende Nummer voranstellt
.DESCRIPTION
   Dieses Modul fügt jedre Zeichenkette einer Nummer voran
.EXAMPLE
   "Thomas" | add-Number
.EXAMPLE
   get-childitems | Add-Number
#>
function add-number
{
    [OutputType([String])]
    Param
    (
        # Der Zeichenkette der eine Nummer hinzugefügt werden soll
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        $name,

        # Die Startnummer
        $num=1

    )

    Begin
    {

    }
    Process
    {
        Write-Host "$num $name" 
        $num++
    }
    End
    {

    }
}