<#
.SYNOPSIS 
Ce script permet de mettre à jour un attribut des utilisateurs via un CSV
.DESCRIPTION
Ce script va charger un csv qui contient le nom d'utilsateur, un attribut et sa nouvelle valeur.
Il va chercher l'utilsateur et mettre à jour l'attibut avec la valeur définie.
On peut l'utiliser pour l'ensemble des attributs LDAP.
.PARAMETER computerName 
Parametre permetant de spécifier le nom ou l'adresse IP du serveur ActiveDiretory
.PARAMETER filePath 
Parametre permetant de spécifier le chemin vers le csv
.EXAMPLE 
Exemple d'usage
.NOTES
Auteur: MrZ3ki3L
Version: 1.0
.LINK 
https://github.com/MrZ3ki3l/PowerShell
#>

#---------------------------------------------------------[Paramètre du script]------------------------------------------------------

Param (
  [Parameter(Mandatory=$True,Position=1)]
  [string]$NomServeurAD,
  [Parameter(Mandatory=$True)]
  [string]$CheminFichierCSV
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

# Défini l'action des erreurs
$ErrorActionPreference = 'SilentlyContinue'

#Import des modules
Import-Module PSLogging

#----------------------------------------------------------[Déclarations]----------------------------------------------------------
# Version du script
$Version_Script = '1.0'

# Information du fichier de log
$Date = Get-Date -Format ("HHmm_ddMMyyyy")
$Chemin_log = 'C:\Windows\Temp'
$Nom_log = 'Maj_Attribut_AD_CSV' + $date + '.log'
$Fichier_log = Join-Path -Path $Chemin_log -ChildPath $Nom_log

#-----------------------------------------------------------[Fonctions]------------------------------------------------------------

# Fonction de demande ID + Mot de passe
function DemandeIDConnexion {
  param ([string]$Serveur)
  $TitreFenetreID = "Demande d'identifiant"
  $MessageCorpFenetreID = "Merci de renseigner les identifiants pour le serveur: " + $Serveur
  $Credential = $host.ui.PromptForCredential($TitreFenetreID, $MessageCorpFenetreID, "", "")
  return $Credential
}

#-----------------------------------------------------------[Interface]------------------------------------------------------------
# Message de presentation l'utilisateur
Write-Host ""
Write-Host "=================================================================="
Write-host "=    Ce script     ="
Write-Host "=								 ="
Write-Host "=								 ="
Write-Host "= Version: $Version_Script		         Réalisation:  ="
Write-Host "=================================================================="
Write-Host ""
Write-Host ""
Write-Host "Appuyer sur une touche pour continuer"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Effacement du terminal
Clear-Host

# Interface
Write-Host ""
Write-Host "======================================"
Write-Host "=	Lancement du script	     ="
Write-Host "======================================"
Write-Host ""

#-----------------------------------------------------------[Traitement]------------------------------------------------------------
# Lancement du log
Start-Log -LogPath $Chemin_log -LogName $Nom_log -ScriptVersion $Version_Script

# Recuperation du contenu du fichier csv
$csvVirtuel = Import-Csv $CheminFichierCSV -Delimiter ";"

# Arret du log
Stop-Log -LogPath $Fichier_log

#-----------------------------------------------------------[Fin du script]------------------------------------------------------------
# Message de au revoir
Write-Host ""
Write-Host ""
Write-Host "Appuyer sur une touche pour quitter"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
