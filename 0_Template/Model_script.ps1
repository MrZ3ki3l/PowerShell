<#
.SYNOPSIS 
Objectifs
.DESCRIPTION 
Ce qu'il va faire
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
 
  
  #----------------------------------------------------------[Déclarations]----------------------------------------------------------
  # Version du script
  $Version_Script = '1.0'
  
  #-----------------------------------------------------------[Fonctions]------------------------------------------------------------
  
  # Fonction d'exemple
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
  Write-host "=         Description         ="
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
  
  
  #-----------------------------------------------------------[Fin du script]------------------------------------------------------------
  # Message de au revoir
  Write-Host ""
  Write-Host ""
  Write-Host "Au revoir !"
  exit 0
  