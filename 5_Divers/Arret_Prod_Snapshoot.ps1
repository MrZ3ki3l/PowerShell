# Import du module pour vCenter
Get-Module -ListAvailable PowerCLI* | Import-Module

# Import de mon module perso
Import-Module /GITLAB/Perso/PowerShell/2_VMware/Fonctions_vmware_perso.ps1

# Ignore les erreurs SSL dû au certificat auto-signé
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore

# Recupération des credentials
$Crendential = Get-Credential

# Connexion au vCenter
Connect-VIServer -Server 10.80.80.10 -Credential $Crendential

# Recupération des VMs
$Serveur_Applicatif = Get-VM -Name PFAS-V-POGUES
$Serveur_BDD = Get-VM -Name PFAS-V-CHAYNES

# Arret du serveur applicatif
Shutdown-VMGuest -VM $Serveur_Applicatif -Confirm

# Arret du serveur BDD
Shutdown-VMGuest -VM $Serveur_BDD -Confirm

# Prise du Snapshoot du serveur BDD
New-Snapshot -VM $Serveur_BDD -Name "MEP_du_18_07_17" -Description "Snapshot avant maj Oracle" -Confirm

# Suppression du lecteur de disquette pour le serveur BDD
$Lecteur_disquette_BDD = Get-FloppyDrive -VM $Serveur_BDD
Remove-FloppyDrive -Floppy $Lecteur_disquette_BDD -Confirm 

# Activation de l'ajout de ram à chaud
Active-ajout-ram-chaud -vm $Serveur_BDD

# Activation de l'ajout de CPU à chaud
Active-ajout_cpu_chaud -vm $Serveur_BDD

# Activation des maj des Vmware Tools au boot
Active-maj-vmware-tools-boot -vm $Serveur_BDD

# Démarrage du Serveur BDD
Start-VM -VM $Serveur_BDD -Confirm

# Suppression du lecteur de disquette pour le serveur Applicatif
$Lecteur_disquette_Applicatif = Get-FloppyDrive -VM $Serveur_Applicatif
Remove-FloppyDrive -Floppy $Lecteur_disquette_Applicatif -Confirm

# Activation de l'ajout de ram à chaud
Active-ajout-ram-chaud -vm $Serveur_Applicatif

# Activation de l'ajout de CPU à chaud
Active-ajout_cpu_chaud -vm $Serveur_Applicatif

# Activation des maj des Vmware Tools au boot
Active-maj-vmware-tools-boot -vm $Serveur_Applicatif

######## En attente que Jean-Marie est fini #########
Write-Host "Appuyer sur une touche quand Jean-Marie donne son feu vert"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Démarrage du Serveur Applicatif
Start-VM -VM $Serveur_Applicatif -Confirm