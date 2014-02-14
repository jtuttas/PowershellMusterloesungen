<#
.Synopsis
   Ein Beipiel CMD let
.DESCRIPTION
   Ein Beipiel CMD let
.EXAMPLE
   bsp.ps1 hallo 5
.EXAMPLE
   bsp.ps1 hallo
#>
function replace-german
{
    [OutputType([String])]
    Param
    (
        # Das zu wiederholende Wort
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [string[]]$file        
    )

    Begin
    {
    }
    Process
    {        
        foreach ($s in $file) {
            $s=$s.replace("ö","oe");
            $s=$s.replace("Ö","OE");
            $s=$s.replace("ä","ae");
            $s=$s.replace("Ä","AE");
            $s=$s.replace("ü","ue");
            $s=$s.replace("Ü","UE");
            $s=$s.replace("ß","ss");
            return $s
        }
    }
    End
    {
    }
}