<#
.SYNOPSIS 
Permet la supervision des liasons VPN inter-site
.DESCRIPTION 
Le script va "pinguer" l'adresse en argument et si l'équipement ne repond 5x au ping, un mail est envoyé à l'adresse en argument
.PARAMETER IP 
Spécifier l'adresse qu'on doit tester
.PARAMETER AdresseMailReceptrice 
Spécifier l'adresse mail receptrice de l'alerte
.PARAMETER AdresseMailEmetrice 
Spécifier l'adresse mail emetrice de l'alerte
.PARAMETER ServeurMail 
Spécifier le serveur de messagerie
.EXAMPLE 
Exemple d'usage
.NOTES
Auteur: MrZ3ki3l
Version: 1.0
.LINK 
https://github.com/MrZ3ki3l/PowerShell
#>

#---------------------------------------------------------[Paramètre du script]------------------------------------------------------

Param (
  [Parameter(Mandatory=$True,Position=1)]
  [string]$IP,
  [Parameter(Mandatory=$True)]
  [string]$AdresseMailReceptrice,
  [Parameter(Mandatory=$True)]
  [string]$AdresseMailEmetrice,
  [Parameter(Mandatory=$True)]
  [string]$ServeurMail
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

# Défini l'action des erreurs
# $ErrorActionPreference = 'SilentlyContinue'

#Import des modules
Import-Module PSLogging

#----------------------------------------------------------[Déclarations]----------------------------------------------------------
# Version du script
$Version_Script = '1.0'

# Information du fichier de log
$Date = Get-Date -Format ("ddMMyyyy_HHmm")
$Chemin_log = "C:\Windows\Temp"
$Nom_log = 'Supervsion_VPN_HCC_CHG' + $date + '.log'
$Fichier_log = Join-Path -Path $Chemin_log -ChildPath $Nom_log

# Récupération de l'IP local
$IP_local = $(Test-Connection ::1 -Cou 1).IPV4Address.IPAddressToString

# Définition du mail
$Sujet = "ALERTE VPN - " + $IP_local + " -> " + $IP
$Corps = "L'element possedant l'adresse IP " + $IP + " n'est plus joinable depuis le serveur ayant l'adresse IP " + $IP_local

# $i = 0
$i = 0

#-----------------------------------------------------------[Fonctions]------------------------------------------------------------

# Fonction de test de la liaison
function Test-Liaison {
  param (
  [string]$IP,
  [string]$NbTest
  )
  
  if(Test-Connection -ComputerName $IP -Delay 1 -Count $NbTest -ea silentlycontinue) {$Etat_liaison = 1}
  else {$Etat_liaison = 0}
  return $Etat_liaison
}

#-----------------------------------------------------------[Interface]------------------------------------------------------------

# Message de presentation l'utilisateur
Write-Host ""
Write-Host "=================================================================="
Write-host "=         Ce script va superviser la liaison inter-site          ="
Write-Host "=								                                 ="
Write-Host "=								                                 ="
Write-Host "= Version: $Version_Script		         Réalisation: MrZ3ki3l   ="
Write-Host "=================================================================="
Write-Host ""

# Interface
Write-Host ""
Write-Host "======================================"
Write-Host "=	Lancement du script	             ="
Write-Host "======================================"
Write-Host ""

#-----------------------------------------------------------[Traitement]------------------------------------------------------------
# Lancement du log
Start-Log -LogPath $Chemin_log -LogName $Nom_log -ScriptVersion $Version_Script
Write-LogInfo -LogPath $Fichier_log -Message "Lancement du script" -TimeStamp

while ($i -eq 0){
	# Test de connexion vers l'IP en argument
	Write-LogInfo -LogPath $Fichier_log -Message "Test d'un ping" -TimeStamp
	$TestConnexion = Test-Liaison -IP $IP -NbTest 1

	if($TestConnexion -eq 0){
		Write-LogWarning -LogPath $Fichier_log -Message "Perte d'un ping" -TimeStamp
		Write-Host -BackgroundColor Yellow "Perte d'un ping"
		Start-Sleep -Seconds 5
		$TestConnexionConfirme =  Test-Liaison -IP $IP -NbTest 10
		Write-LogInfo -LogPath $Fichier_log -Message "Test de 10 ping" -TimeStamp
		if ($TestConnexionConfirme -eq 0){
			Write-LogWarning -LogPath $Fichier_log -Message "Perte de 10 ping" -TimeStamp
			Write-Host -BackgroundColor Red "Perte de 10 ping"
			Send-MailMessage -Body $Corps -to $AdresseMailReceptrice -from $AdresseMailEmetrice -Subject $Sujet -SmtpServer $ServeurMail
			Write-LogWarning -LogPath $Fichier_log -Message "Envoi du mail" -TimeStamp
            Start-Sleep -Seconds 600
		}
	}
    
    if($TestConnexion -eq 1){
        Write-Host -BackgroundColor Green "La liaison est opérationnelle"
        Write-LogInfo -LogPath $Fichier_log -Message "Connexion opérationnelle" -TimeStamp
    }
    
    Start-Sleep -Seconds 30
}
# Arret du log
Stop-Log -LogPath $Fichier_log

#-----------------------------------------------------------[Fin du script]------------------------------------------------------------
# Message de au revoir
Write-Host ""
Write-Host ""
Write-Host "Au revoir !"
exit 0
