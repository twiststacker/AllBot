param(
  [psobject]$Payload,
  [psobject]$Config
)

Write-Host 'OverBot invoked with payload:' $( | ConvertTo-Json)

# TODO: implement OverBot logic

@{
  Bot      = 'OverBot'
  Type     = 'Status'
  Severity = 'Info'
  Message  = 'Stub executed'
} | ConvertTo-Json
