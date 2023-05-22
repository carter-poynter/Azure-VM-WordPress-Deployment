# Variables
$resourceGroupName = "myResourceGroup"
$location = "westus"
$vmName = "myUbuntuVM"
$vmSize = "Standard_B1s"
$adminUsername = "azureuser"
$adminPassword = "YourPassword123"  # Replace with your desired password
$kickstartFilePath = "kickstart.sh"
$ctx = New-AzStorageContext -StorageAccountName carterscli -UseConnectedAccount # Creates a context for the Azure storage account

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create the virtual machine
New-AzVm -ResourceGroupName $resourceGroupName -Name $vmName -Location $location `
  -ImagePublisher "Canonical" -ImageOffer "UbuntuServer" -ImageSku "18.04-LTS" `
  -Credential (New-Object System.Management.Automation.PSCredential -ArgumentList $adminUsername, (ConvertTo-SecureString -String $adminPassword -AsPlainText -Force)) `
  -Size $vmSize

# Push the kickstart script to the VM
Set-AzVMExtension -ResourceGroupName $resourceGroupName -VMName $vmName -Name "customScript" -Publisher "Microsoft.Azure.Extensions" -ExtensionType "CustomScript" -TypeHandlerVersion "2.1" -SettingString "{\"commandToExecute\": \"bash $kickstartFilePath\"}"