param(
  [psobject]$Config,
  [string]  $LogFile
)

# 1) Authenticate (assumes Az module logged in)
Write-Host "VaultBot: Listing secrets in $($Config.KeyVaultName)"
$secrets = Get-AzKeyVaultSecret -VaultName $Config.KeyVaultName -ErrorAction Stop

# 2) Rotate secrets older than threshold
$rotated = 0
foreach ($sec in $secrets) {
  if ((Get-Date) -gt $sec.Attributes.Created + (New-TimeSpan -Hours $Config.RotateEveryHours)) {
    # placeholder rotation logic
    $rotated++
  }
}

# 3) Log activity
Add-Content $LogFile "`$(Get-Date): VaultBot → SecretsFound=$($secrets.Count),Rotated=$rotated"

# 4) Event
$event = @{
  Bot      = 'VaultBot'
  Type     = 'Maintenance'
  Severity = 'Info'
  Message  = "Checked $($secrets.Count) secrets, rotated $rotated"
}

$event | ConvertTo-Json