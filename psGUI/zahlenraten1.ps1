#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 12.03.2014 15:37
# Generated By: kemmries
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$okayB = New-Object System.Windows.Forms.Button
$zahlL = New-Object System.Windows.Forms.Label
$ergebnisL = New-Object System.Windows.Forms.Label
$auswahlTB = New-Object System.Windows.Forms.TrackBar
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

$min = 1
$max = 100
$global:versuch = 1
[int]$global:random = Get-Random -Minimum 1 -Maximum 100

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$handler_label1_Click= 
{
#TODO: Place custom script here

}

$okayB_OnClick= 
{
#TODO: Place custom script here
 if ($auswahlTB.Value -lt $global:random)
   {
    $ergebnisL.Text = [String]$global:versuch + ". Versuch: Zahl zu klein gewählt"
    $global:versuch++
   }
  elseif ($auswahlTB.Value -gt $global:random)
   {
    $ergebnisL.Text = [String]$global:versuch + ". Versuch: Zahl zu groß gewählt"
    $global:versuch++
   }
   else
    {
     $ergebnisL.Text = "Prima, du hast es in " + $global:versuch + " Versuchen geschafft! Es geht von vorne los"
     $global:versuch = 1
     [int]$global:random = Get-Random -Minimum 1 -Maximum 100
    }
}

$auswahlTB_ValueChanged= 
{
#TODO: Place custom script here

 $zahlL.text = $auswahlTB.Value

}


$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$form1.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 262
$System_Drawing_Size.Width = 284
$form1.ClientSize = $System_Drawing_Size
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$form1.Name = "form1"
$form1.Text = "Zahlenraten"


$okayB.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 108
$System_Drawing_Point.Y = 177
$okayB.Location = $System_Drawing_Point
$okayB.Name = "okayB"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 75
$okayB.Size = $System_Drawing_Size
$okayB.TabIndex = 3
$okayB.Text = "Okay"
$okayB.UseVisualStyleBackColor = $True
$okayB.add_Click($okayB_OnClick)

$form1.Controls.Add($okayB)

$zahlL.DataBindings.DefaultDataSourceUpdateMode = 0
$zahlL.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",18,0,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 108
$System_Drawing_Point.Y = 49
$zahlL.Location = $System_Drawing_Point
$zahlL.Name = "zahlL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 74
$zahlL.Size = $System_Drawing_Size
$zahlL.TabIndex = 2
$zahlL.Text = "?"
$zahlL.TextAlign = 32

$form1.Controls.Add($zahlL)

$ergebnisL.BorderStyle = 1
$ergebnisL.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 29
$System_Drawing_Point.Y = 222
$ergebnisL.Location = $System_Drawing_Point
$ergebnisL.Name = "ergebnisL"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 233
$ergebnisL.Size = $System_Drawing_Size
$ergebnisL.TabIndex = 1
$ergebnisL.Text = [String] $global:versuch + ". Versuch:"
$ergebnisL.add_Click($handler_label1_Click)

$form1.Controls.Add($ergebnisL)

$auswahlTB.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 29
$System_Drawing_Point.Y = 101
$auswahlTB.Location = $System_Drawing_Point
$auswahlTB.Name = "auswahlTB"
$auswahlTB.Maximum=$max
$auswahlTB.Minimum=$min

$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 45
$System_Drawing_Size.Width = 233
$auswahlTB.Size = $System_Drawing_Size
$auswahlTB.TabIndex = 0

$auswahlTB.add_ValueChanged($auswahlTB_ValueChanged)

$form1.Controls.Add($auswahlTB)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form1.WindowState
#Init the OnLoad event to correct the initial state of the form
$form1.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form1.ShowDialog()| Out-Null



} #End Function

#Call the Function
GenerateForm