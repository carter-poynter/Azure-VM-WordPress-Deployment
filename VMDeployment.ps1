# Variables
$resourceGroupName = "myResourceGroup"
$location = "EastUS"
$vmName = "myUbuntuVM"
$vmSize = "Standard_B1s"
$adminUsername = "azureuser"
$adminPassword = "YourPassword123"  # Replace with your desired password
$kickstartFilePath = "C:\path\kickstart.sh" # Use absolute path

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create the virtual machine
New-AzVm `
  -ResourceGroupName $resourceGroupName `
  -Name $vmName `
  -Location $location `
  -Image Ubuntu2204 `
  -size $vmSize `
  -PublicIpAddressName myPubIP `
  -OpenPorts 80 `
  -Credential (New-Object System.Management.Automation.PSCredential -ArgumentList $adminUsername, (ConvertTo-SecureString -String $adminPassword -AsPlainText -Force)) 

# run command
Invoke-AzVMRunCommand -ResourceGroupName $resourceGroupName -Name $vmName -CommandId 'RunShellScript' -ScriptPath $kickstartFilePath