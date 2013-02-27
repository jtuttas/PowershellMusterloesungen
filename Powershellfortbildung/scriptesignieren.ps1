new-codesigncert -Name SecuritMMBBS -CreateTrust
$cert = dir Cert:\CurrentUser\my\B0E38DBA4FCDDE59C04*
Set-AuthenticodeSignature -Certificate $cert -FilePath C:\Users\PowerLehr.PowerLehr-PC\Desktop\h96.ps1
