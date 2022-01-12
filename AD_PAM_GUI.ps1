#This is the function that sets temporary user access to the Security group of choice.
Function Set-ADGroupMember($User,$Group,$increments,$units){
    if ($units -eq "days"){
        Add-ADGroupMember -Identity $Group -Members $User -MemberTimeToLive(new-timespan -days $increments)
        get-adgroup $group -property member -ShowMemberTimeToLive
        }
    else{
        Add-ADGroupMember -Identity $Group -Members $User -MemberTimeToLive(new-timespan -hours $increments)
        get-adgroup $group -property member -ShowMemberTimeToLive
        }
}
#required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#Creates the gui window
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Closed Folder Access'
$form.Size = New-Object System.Drawing.Size(800,400)
$form.StartPosition = 'CenterScreen'

#Defines the OK button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,300)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

#Defines the Cancel Button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,300)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

#Select a Security Group Label
$SGLabel = New-Object System.Windows.Forms.Label
$SGLabel.Location = New-Object System.Drawing.Point(10,15)
$SGLabel.Size = New-Object System.Drawing.Size(150,20)
$SGLabel.Text = 'Select a Folder:'
$form.Controls.Add($SGLabel)

#Select a Security Group listbox
$SecGroup = New-Object System.Windows.Forms.ListBox
$SecGroup.Location = New-Object System.Drawing.Point(10,40)
$SecGroup.Size = New-Object System.Drawing.Size(160,20)
$SecGroup.Height = 80

#Select a user label
$UsrLabel = New-Object System.Windows.Forms.Label
$UsrLabel.Location = New-Object System.Drawing.Point(200,15)
$UsrLabel.Size = New-Object System.Drawing.Size(180,20)
$UsrLabel.Text = 'Select a User:'
$form.Controls.Add($UsrLabel)

#Select a user listbox
$username = New-Object System.Windows.Forms.ListBox
$username.Location = New-Object System.Drawing.Point(200,40)
$username.Size = New-Object System.Drawing.Size(160,20)
$username.Height = 80

#Select a unit of measurement days/hours label
$UoMLabel = New-Object System.Windows.Forms.Label
$UoMLabel.Location = New-Object System.Drawing.Point(400,15)
$UoMLabel.Size = New-Object System.Drawing.Size(180,20)
$UoMLabel.Text = 'Select a Unit'
$form.Controls.Add($UoMLabel)

#Select days/hours listbox
$unitsOfM = New-Object System.Windows.Forms.ListBox
$unitsOfM.Location = New-Object System.Drawing.Point(400,40)
$unitsOfM.Size = New-Object System.Drawing.Size(160,20)
$unitsOfM.Height = 80

#select the number of days or hours label
$incrLabel = New-Object System.Windows.Forms.Label
$incrLabel.Location = New-Object System.Drawing.Point(600,15)
$incrLabel.Size = New-Object System.Drawing.Size(180,20)
$incrLabel.Text = 'Select an Increment'
$form.Controls.Add($incrLabel)

#select the number of days or hours listbox
$incr = New-Object System.Windows.Forms.ListBox
$incr.Location = New-Object System.Drawing.Point(620,40)
$incr.Size = New-Object System.Drawing.Size(150,20)
$incr.Height = 80

#the options for available security groups in the listbox.  Change SG# to whatever you named your AD security groups. 
[void] $SecGroup.Items.Add('SG1')
[void] $SecGroup.Items.Add('SG2')
[void] $SecGroup.Items.Add('SG3')
[void] $SecGroup.Items.Add('SG4')
[void] $SecGroup.Items.Add('SG5')
[void] $SecGroup.Items.Add('SG6')
[void] $SecGroup.Items.Add('SG7')
[void] $SecGroup.Items.Add('SG8')
[void] $SecGroup.Items.Add('SG9')
[void] $SecGroup.Items.Add('SG10')

#the options for available users in the listbox.  just add another line if you need to add another
[void] $username.items.add('USR1')
[void] $username.items.add('USR2')
[void] $username.items.add('USR3')
[void] $username.items.add('USR4')
[void] $username.items.add('USR5')
[void] $username.items.add('USR6')
[void] $username.items.add('USR7')
[void] $username.items.add('USR8')
[void] $username.items.add('USR9')
[void] $username.items.add('USR10')

#the options for the unit of measurement in the listbox. Can be days hours minutes seconds
[void] $unitsOfM.items.add('days')
[void] $unitsOfM.items.add('hours')

#the options the the number of hours or days can add whatever you want.  
[void] $incr.items.add(1)
[void] $incr.items.add(2)
[void] $incr.items.add(3)
[void] $incr.items.add(4)
[void] $incr.items.add(5)
[void] $incr.items.add(6)
[void] $incr.items.add(7)
[void] $incr.items.add(8)

#To publish the listboxes in the window.  If you don't add this you don't see it
$form.Controls.Add($SecGroup)
$form.controls.add($username)
$form.controls.add($unitsOfM)
$form.controls.add($incr)
$form.Topmost = $true

#check to see if ok was pressed
$result = $form.showDialog()
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
#assign variables from the options selected
       $User=$username.Selecteditem
       $Group=$SecGroup.selectedItem
       $increments=$incr.selectedItem
       $units=$unitsOfM.selectedItem
       #call the function and pass the variables
       Set-ADGroupMember $User $Group $increments $units
}

