﻿# Auf dem Remote Computer muss die POwershell als Admin ausgeführt werden und Enable-PSRemoting aktiviert werden!
# Die Firewall muss für WMI durchgängig sein und der RPC Dienst muss auf dem zugegriffenen Computer laufen

param (
    $computer="localhost",
    $user=""
)
#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 17.02.2014 14:00
# Generated By: Joerg-T400
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$label1 = New-Object System.Windows.Forms.Label
$timer1 = New-Object System.Windows.Forms.Timer
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$handler_form1_FormClosed= 
{
#TODO: Place custom script here

}

$tick= 
{
    if ($user.Length -ne 0) {
        $d=Get-WmiObject Win32_Processor -ComputerName $computer -Credential $c
    }
    else {
        $d=Get-WmiObject Win32_Processor 
    }
    $label1.Text=""+$d.LoadPercentage+"%"
#TODO: Place custom script here

}

$handler_form1_FormClosing= 
{
#TODO: Place custom script here
    $timer1.Stop()
}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$form1.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 112
$System_Drawing_Size.Width = 288
$form1.ClientSize = $System_Drawing_Size
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$form1.Name = "form1"
$form1.Text = "CPU Auslastung"
$form1.add_FormClosed($handler_form1_FormClosed)
$form1.add_FormClosing($handler_form1_FormClosing)

$label1.DataBindings.DefaultDataSourceUpdateMode = 0
$label1.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",26.25,0,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 9
$label1.Location = $System_Drawing_Point
$label1.Name = "label1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 94
$System_Drawing_Size.Width = 264
$label1.Size = $System_Drawing_Size
$label1.TabIndex = 0
$label1.Text = "%"
$label1.TextAlign = 32

$form1.Controls.Add($label1)

$timer1.Enabled = $True
$timer1.Interval = 2000
$timer1.add_Tick($tick)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form1.WindowState
#Init the OnLoad event to correct the initial state of the form
$form1.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form1.ShowDialog()| Out-Null

} #End Function

if ($user.Length -ne 0) {
    $c=Get-Credential $user
}

#Call the Function
GenerateForm
