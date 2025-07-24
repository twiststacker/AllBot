<# 
.SYNOPSIS
  GiGBot – sends notifications to Microsoft Teams.
#>

param (
    [string]$Message = "Hello from GiGBot"
)

# TODO: POST $Message to the Teams webhook defined in config.json
Write-Host "GiGBot would send: $Message"