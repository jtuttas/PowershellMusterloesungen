param ($id,$mail)

<#
.Synopsis
   Kurzbeschreibung
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Beispiel für die Verwendung dieses Cmdlets
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
function send-request
{
    [OutputType([String])]
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true,
                   Position=0)]
        [String]$id,

        # Hilfebeschreibung zu Param2
        [Parameter(Mandatory=$true,
                   Position=1)]
        [String]$email
    )

    Begin
    {
      $username="tuttas68@googlemail.com"
      if (Test-Path C:\Temp\serurestring.txt) {
        Write-Host "Found Secure String"
        $password = Get-Content C:\Temp\serurestring.txt | convertto-securestring
        $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
      }
      else {
            $cred = Get-Credential -UserName $username -Message "Kennwort f. Mailserver"
            ConvertFrom-SecureString $cred.Password | Set-Content C:\Temp\serurestring.txt
      }
      
      $SMTPServer="smtp.gmail.com"
      $SMTPPort="587"
      $body=" Bitte Klicken Sie auf den Link http://localhost/sql.php?id="+$id;
      Send-MailMessage -From "tuttas@mmbbs.de" -to $email -Subject "Kennwort Wiederherstellung" -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl -Credential $cred
    }
    Process
    {
    }
    End
    {
        return "send mail to $email"
    }
}

send-request $id $mail