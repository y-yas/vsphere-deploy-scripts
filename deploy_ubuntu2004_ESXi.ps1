$VCSAHostname = "vcsa.homelab.local"
$VCSAUsername = "administrator@vsphere.local"
$VCSAPassword = "Password"
$DatastoreName = "datastore1"
$VDSPG = "PG"
$VMName = "ubuntu01"
$VMDisksize = "40"
$VMCPU = "2"
$VMCoreSocket = "1"
$VMMemory = "4"
$VMGuestID = "ubuntu64Guest"
$ESXiHostname = "esx.homelab.local"


Connect-VIServer "$VCSAHostname" -User "$VCSAUsername" -Password "$VCSAPassword" -Force

Write-Host "VMName:" -NoNewLine

New-VM -Name $VMname -VMHost $ESXiHostname -Datastore $DatastoreName -NumCpu $VMCPU -DiskGB $VMDisksize -MemoryGB $VMMemory -DiskStorageFormat 'thin' -NetworkName $VDSPG -CD -GuestID $VMGuestID

$vm = Get-VM $VMName
$vm | Get-CDDrive | Set-CDDrive -ISOPath "[$DatastoreName] ubuntu-20.04-desktop-amd64.iso" -StartConnected $true -Confirm:$false

$vm | Start-VM

Disconnect-VIServer -Confirm:$false

