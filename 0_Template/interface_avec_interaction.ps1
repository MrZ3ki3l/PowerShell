#Requires -Version 3.0
<#
.SYNOPSIS 
Bref description du script
.DESCRIPTION 
Description int�grale du script
.PARAMETER name 
Description des param�tres (un parametre / .)
.EXAMPLE 
Exemple d'usage
.NOTES
Auteur:
Version:
.LINK 
https://github.com/MrZ3ki3l/PowerShell
#>

#---------------------------------------------------------[Param�tre du script]------------------------------------------------------

Param (
  #Param�tre du script ici
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

# D�fini l'action des erreurs
$ErrorActionPreference = 'SilentlyContinue'

#Import des modules
Import-Module PSLogging

#----------------------------------------------------------[D�clarations]----------------------------------------------------------
# Version du script
$Version_Script = '1.0'

# Information du fichier de log
$Date = Get-Date -Format ("HHmm_ddMMyyyy")
$Chemin_log = 'C:\Windows\Temp'
$Nom_log = '<nom_script>' + $date + '.log'
$Fichier_log = Join-Path -Path $Chemin_log -ChildPath $Nom_log

#-----------------------------------------------------------[Fonctions]------------------------------------------------------------
#
#
#
#-----------------------------------------------------------[Interface]------------------------------------------------------------
# Message de presentation l'utilisateur
Write-Host ""
Write-Host "=================================================================="
Write-host "=    Ce script     ="
Write-Host "=								 ="
Write-Host "=								 ="
Write-Host "= Version:		         R�alisation:  ="
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
Start-Log -LogPath $Fichier_log -LogName $Nom_log -ScriptVersion $Version_Script

#
# code ici
#

# Arret du log
Stop-Log -LogPath $Fichier_log

#-----------------------------------------------------------[Fin du script]------------------------------------------------------------
# Message de au revoir
Write-Host ""
Write-Host ""
Write-Host "Appuyer sur une touche pour quitter"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
