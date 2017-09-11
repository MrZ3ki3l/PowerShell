# Fonction permettant l'ajout de ram à chaud sans l'arret de la machine
Function Active-ajout-ram-chaud($vm){
    $vmview = Get-vm $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="mem.hotadd"
    $extra.Value="true"
    $vmConfigSpec.extraconfig += $extra
    $vmview.ReconfigVM($vmConfigSpec)
}
# Fonction désactivant l'ajout de RAM à chaud
Function Desactive-ajour-ram-chaud($vm){
    $vmview = Get-VM $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="mem.hotadd"
    $extra.Value="false"
    $vmConfigSpec.extraconfig += $extra
    $vmview.ReconfigVM($vmConfigSpec)
}
# Focntion permettant l'ajout de vCPU à chaud sans l'arret de la machine
Function Active-ajout_cpu_chaud($vm){
    $vmview = Get-vm $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec

    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="vcpu.hotadd"
    $extra.Value="true"
    $vmConfigSpec.extraconfig += $extra
    $vmview.ReconfigVM($vmConfigSpec)
}
# Focntion désactivant l'ajout de vCPU à chaud
Function Desactive-ajout_cpu_chaud($vm){
    $vmview = Get-vm $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="vcpu.hotadd"
    $extra.Value="false"
    $vmConfigSpec.extraconfig += $extra
    $vmview.ReconfigVM($vmConfigSpec)
}

# Fonction d'activation des maj des vmware tools au boot
Function Active-maj-vmware-tools-boot($vm){
    $vm = $vm | Get-View
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $vmConfigSpec.Tools = New-Object VMware.Vim.ToolsConfigInfo
    $vmConfigSpec.Tools.ToolsUpgradePolicy = "UpgradeAtPowerCycle"
    $vm.ReconfigVM($vmConfigSpec)
}

# Fonction de désactivation des maj des vmware tools au boot
Function desactive-maj-vmware-tools-boot($vm){
    $vm = $vm | Get-View
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $vmConfigSpec.Tools = New-Object VMware.Vim.ToolsConfigInfo
    $vmConfigSpec.Tools.ToolsUpgradePolicy = "manual"
    $vm.ReconfigVM($vmConfigSpec)
}