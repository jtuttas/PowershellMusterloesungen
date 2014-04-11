<#
.Synopsis
   Liest die wichtigsten Informationen von einem Computer ein
.DESCRIPTION
   Dieses CMDlet kann Systeminformationen von einem lokalen oder remote Computer einlesen
.EXAMPLE
   get-ComputerInfo

   IPAdresse: 127.0.0.1
   MACAdress: 11:22:33:44:55:66
   OS-Architektur: 64
   RAM: 8192
   free Disk Space: 3643623
   Computername: training.ad.eu.rf-group.org

.EXAMPLE
   get-ComputerInfo -ComputerName "10.145.76.54"

   IPAdresse: 10.145.76.54
   MACAdress: 11:22:33:44:55:66
   OS-Architektur: 64
   RAM: 8192
   free Disk Space: 3643623
   Computername: training.ad.eu.rf-group.org

.EXAMPLE
   get-ComputerInfo -ComputerName "10.145.76.54","10.145.76.55"

   IPAdresse: 10.145.76.54
   MACAdress: 11:22:33:44:55:66
   OS-Architektur: 64
   RAM: 8192
   free Disk Space: 3643623
   Computername: training.ad.eu.rf-group.org

   IPAdresse: 10.145.76.55
   MACAdress: 11:22:33:44:55:67
   OS-Architektur: 64
   RAM: 3192
   free Disk Space: 324723645
   Computername: training.ad.eu.rf-group.org

.EXAMPLE
   "10.145.76.54","10.145.76.55" | get-ComputerInfo 
.EXAMPLE
   "10.145.76.54","10.145.76.55" | get-ComputerInfo | out-GridView 
.EXAMPLE
   import-csv ipadressen.csv | get-ComputerInfo | out-GridView 
#>
function get-ComputerInfo
{
    
    [OutputType([Object])]
    Param
    (
        # Der Computername oder die IP Adresse eines remote Computers
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   Position=0)]
        [String[]]$ComputerName,

        # Das Authentifizierungsopbject
        [PSCredential]$Credential

    )

    Begin
    {
        
    }
    Process
    {
        foreach ($com in $ComputerName) {
            $remoteCi={
                $ci=New-Object System.Object | Select-Object -Property MACAddress,Architecture,OS,RAM,freeDiskspace,ComputerName
                $ci.MACAddress=Get-WmiObject win32_networkadapterconfiguration | Where-Object ipaddress | Select-Object -ExpandProperty MACAddress
                $ci.Architecture=(Get-WmiObject win32_operatingsystem).OSArchitecture
                $ci.OS=(Get-WmiObject win32_operatingsystem).Caption
                [double]$ci.RAM=(Get-WmiObject win32_computersystem).totalPhysicalmemory/1gb 
                $ci.freeDiskspace=(Get-WmiObject win32_logicaldisk) | Where-Object {$_.DeviceID -eq "c:"} | Select-Object -ExpandProperty FreeSpace
                $ci.ComputerName=$env:COMPUTERNAME
                $ci
            }
            try {
                Invoke-Command -ComputerName $com -Credential $Credential -ScriptBlock $remoteCi -OutVariable remoteOut -ErrorAction SilentlyContinue | Out-Null
                $remoteOut
            }
            catch {
                Write-Host "Konnte den Rechner $com nicht erreichen"
            }
        }
    }
    End
    {
  }    
}
