#******** Mit dieser Kommentierung werden hinzugefügte Codezeilen eingefasst
#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 26/03/2014 5:20 PM
# Generated By: Jochen
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
#endregion

#region Generated Form Objects
$dbconfigF = New-Object System.Windows.Forms.Form
$saveB = New-Object System.Windows.Forms.Button
$cancelB = New-Object System.Windows.Forms.Button
$dbnameTB = New-Object System.Windows.Forms.TextBox
$passTB = New-Object System.Windows.Forms.TextBox
$userTB = New-Object System.Windows.Forms.TextBox
$serverTB = New-Object System.Windows.Forms.TextBox
$dbnameL = New-Object System.Windows.Forms.Label
$passL = New-Object System.Windows.Forms.Label
$userL = New-Object System.Windows.Forms.Label
$serverL = New-Object System.Windows.Forms.Label
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#********
# XML mit DB Zugangsdaten einlesen
[xml]$dbconfigx = get-content "$PSScriptRoot\dbconfig.xml"
#********

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$cancelB_OnClick= 
{
#TODO: Place custom script here

#********
  # Anwendung schließen mit Abbrechen Button
  $dbconfigF.close()
#********

}

$handler_label1_Click= 
{
#TODO: Place custom script here

}

$saveB_OnClick= 
{
#TODO: Place custom script here

#********
#Eingabefeldwerte im XML-Objekt speichern und die Datei sichern
$dbconfigx.dbconfig.dbserver = $serverTB.Text
$dbconfigx.dbconfig.dbuser = $userTB.Text
$dbconfigx.dbconfig.dbpassword = $passTB.Text
$dbconfigx.dbconfig.dbname = $dbnameTB.Text
$dbconfigx.save("$PSScriptRoot\dbconfig.xml")
#********

}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$dbconfigF.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 210
$System_Drawing_Size.Width = 415
$dbconfigF.ClientSize = $System_Drawing_Size
$dbconfigF.DataBindings.DefaultDataSourceUpdateMode = 0
$dbconfigF.Name = "dbconfigF"
$dbconfigF.Text = "WOL - DB Zugang konfigurieren"


$saveB.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 230
$System_Drawing_Point.Y = 177
$saveB.Location = $System_Drawing_Point
$saveB.Name = "saveB"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 75
$saveB.Size = $System_Drawing_Size
$saveB.TabIndex = 10
$saveB.Text = "Speichern"
$saveB.UseVisualStyleBackColor = $True
$saveB.add_Click($saveB_OnClick)

$dbconfigF.Controls.Add($saveB)


$cancelB.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 328
$System_Drawing_Point.Y = 177
$cancelB.Location = $System_Drawing_Point
$cancelB.Name = "cancelB"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 75
$cancelB.Size = $System_Drawing_Size
$cancelB.TabIndex = 9
$cancelB.Text = "Abbrechen"
$cancelB.UseVisualStyleBackColor = $True
$cancelB.add_Click($cancelB_OnClick)

$dbconfigF.Controls.Add($cancelB)

$dbnameTB.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 110
$System_Drawing_Point.Y = 146
$dbnameTB.Location = $System_Drawing_Point
$dbnameTB.Name = "dbnameTB"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 100
$dbnameTB.Size = $System_Drawing_Size
$dbnameTB.TabIndex = 7

#********
#Gespeicherte Werte in das Eingabefeld schreiben
$dbnameTB.Text = $dbconfigx.dbconfig.dbname
#********

$dbconfigF.Controls.Add($dbnameTB)

$passTB.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 110
$System_Drawing_Point.Y = 103
$passTB.Location = $System_Drawing_Point
$passTB.Name = "passTB"
#$passTB.PasswordChar = '*'
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 100
$passTB.Size = $System_Drawing_Size
$passTB.TabIndex = 6

#********
#Gespeicherte Werte in das Eingabefeld schreiben
$passTB.Text = $dbconfigx.dbconfig.dbpassword
#********

$dbconfigF.Controls.Add($passTB)

$userTB.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 110
$System_Drawing_Point.Y = 60
$userTB.Location = $System_Drawing_Point
$userTB.Name = "userTB"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 100
$userTB.Size = $System_Drawing_Size
$userTB.TabIndex = 5

#********
#Gespeicherte Werte in das Eingabefeld schreiben
$userTB.Text = $dbconfigx.dbconfig.dbuser
#********

$dbconfigF.Controls.Add($userTB)

$serverTB.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 110
$System_Drawing_Point.Y = 21
$serverTB.Location = $System_Drawing_Point
$serverTB.Name = "serverTB"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 100
$serverTB.Size = $System_Drawing_Size
$serverTB.TabIndex = 4

#********
#Gespeicherte Werte in das Eingabefeld schreiben
$serverTB.Text = $dbconfigx.dbconfig.dbserver
#********

$dbconfigF.Controls.Add($serverTB)

$dbnameL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 24
$System_Drawing_Point.Y = 146
$dbnameL.Location = $System_Drawing_Point
$dbnameL.Name = "dbnameL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$dbnameL.Size = $System_Drawing_Size
$dbnameL.TabIndex = 3
$dbnameL.Text = "DB Name"

$dbconfigF.Controls.Add($dbnameL)

$passL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 24
$System_Drawing_Point.Y = 103
$passL.Location = $System_Drawing_Point
$passL.Name = "passL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$passL.Size = $System_Drawing_Size
$passL.TabIndex = 2
$passL.Text = "Passwort"

$dbconfigF.Controls.Add($passL)

$userL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 24
$System_Drawing_Point.Y = 60
$userL.Location = $System_Drawing_Point
$userL.Name = "userL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$userL.Size = $System_Drawing_Size
$userL.TabIndex = 1
$userL.Text = "Benutzer"

$dbconfigF.Controls.Add($userL)

$serverL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 24
$System_Drawing_Point.Y = 21
$serverL.Location = $System_Drawing_Point
$serverL.Name = "serverL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$serverL.Size = $System_Drawing_Size
$serverL.TabIndex = 0
$serverL.Text = "Server"
$serverL.add_Click($handler_label1_Click)

$dbconfigF.Controls.Add($serverL)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $dbconfigF.WindowState
#Init the OnLoad event to correct the initial state of the form
$dbconfigF.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$dbconfigF.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm