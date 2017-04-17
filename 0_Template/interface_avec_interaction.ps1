#Requires -Version 3.0
<#
.SYNOPSIS 
Bref description du script
.DESCRIPTION 
Description intégrale du script
.PARAMETER name 
Description des paramètres (un parametre / .)
.EXAMPLE 
Exemple d'usage
.NOTES
Auteur:
Version:
.LINK 
https://github.com/MrZ3ki3l/PowerShell
#>

# Message de presentation l'utilisateur
Write-Host ""
Write-Host "=================================================================="
Write-host "=    Ce script     ="
Write-Host "=								 ="
Write-Host "=								 ="
Write-Host "= Version:		         Réalisation:  ="
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

# Traitement

# Message de au revoir
Write-Host ""
Write-Host ""
Write-Host "Appuyer sur une touche pour quitter"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
