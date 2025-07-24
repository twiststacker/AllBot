<#
.SYNOPSIS
  Full scaffold for C:\ALLBOT: folders, hidden files, API + UI, orchestrator, and bot stubs.

.RUNASADMIN
  This script must run as Administrator.
#>

param(
  [string]$Root = "C:\ALLBOT"
)

function New-Folder([string]$path) {
  if (-not (Test-Path $path)) {
    New-Item -Path $path -ItemType Directory -Force | Out-Null
    Write-Host "Created folder: $path"
  }
}

# 1. Create directory tree
$dirs = @(
  'src\client\api\controllers',
  'src\client\api\middleware',
  'src\client\ui',
  'src\orchestrator',
  'src\bots\OverBot',
  'src\bots\SecuBot',
  'src\bots\StreamBot',
  'src\bots\ThrottleBot',
  'src\bots\VaultBot',
  'config',
  'scripts',
  'docs'
)
foreach ($d in $dirs) {
  New-Folder (Join-Path $Root $d)
}

# 2. Hidden .gitignore
$gitignorePath = Join-Path $Root '.gitignore'
$gitignoreContent = @"
node_modules/
.env
config/production.json
"@
Set-Content -Path $gitignorePath -Value $gitignoreContent -Force
attrib +h $gitignorePath
Write-Host "Created hidden file: $gitignorePath"

# 3. Config files
# 3a. default.json
$defaultJson = Join-Path $Root 'config\default.json'
$defaultContent = @"
{
  "environment": "development",
  "api": {
    "port": 3000,
    "throttle": { "windowMs": 60000, "max": 100 }
  }
}
"@
Set-Content -Path $defaultJson -Value $defaultContent -Force

# 3b. production.json (hidden)
$prodJson = Join-Path $Root 'config\production.json'
$prodContent = @"
{
  "environment": "production",
  "api": {
    "port": 80,
    "throttle": { "windowMs": 60000, "max": 1000 }
  }
}
"@
Set-Content -Path $prodJson -Value $prodContent -Force
attrib +h $prodJson
Write-Host "Created hidden file: $prodJson"

# 4. README.md
$readme = Join-Path $Root 'README.md'
Set-Content -Path $readme -Value '# ALLBOT Service Scaffold' -Force

# 5. docker-compose.yml
$dc = Join-Path $Root 'docker-compose.yml'
$dcContent = @"
version: '3.8'
services:
  api:
    build: ./src/client/api
    ports:
      - '3000:3000'
  orchestrator:
    image: mcr.microsoft.com/powershell:lts
    volumes:
      - ./src/orchestrator:/scripts
    command: powershell ./scripts/orchestrator.ps1
"@
Set-Content -Path $dc -Value $dcContent -Force

# 6. docs\architecture.md
$arch = Join-Path $Root 'docs\architecture.md'
Set-Content -Path $arch -Value '# Architecture Diagram (Insert ASCII/Visio here)' -Force

# 7. Client/API files
$apiRoot = Join-Path $Root 'src\client\api'

# 7a. package.json
$pkg = Join-Path $apiRoot 'package.json'
$pkgContent = @"
{
  "name": "allbot-api",
  "version": "1.0.0",
  "main": "server.js",
  "dependencies": {
    "express": "^4.18.2",
    "express-rate-limit": "^6.7.0"
  }
}
"@
Set-Content -Path $pkg -Value $pkgContent -Force

# 7b. server.js
$server = Join-Path $apiRoot 'server.js'
$serverContent = @"
const express = require('express');
const rateLimiter = require('./middleware/rateLimiter');
const throttleCtrl = require('./controllers/throttleController');

const app = express();
app.use('/api', rateLimiter);
app.get('/api/throttle', throttleCtrl);
app.listen(process.env.PORT || 3000, () => {
  console.log('API listening on port', process.env.PORT || 3000);
});
"@
Set-Content -Path $server -Value $serverContent -Force

# 7c. rateLimiter.js
$rl = Join-Path $apiRoot 'middleware\rateLimiter.js'
$rlContent = @"
const rateLimit = require('express-rate-limit');
const config = require('../../../config/default.json');

module.exports = rateLimit({
  windowMs: config.api.throttle.windowMs,
  max: config.api.throttle.max
});
"@
Set-Content -Path $rl -Value $rlContent -Force
Write-Host "Created file: $rl"

# 7d. throttleController.js
$tc = Join-Path $apiRoot 'controllers\throttleController.js'
$tcContent = @"
module.exports = (req, res) => {
  res.json({ message: 'Request allowed', timestamp: Date.now() });
};
"@
Set-Content -Path $tc -Value $tcContent -Force

# 8. Client/UI files
$uiRoot = Join-Path $Root 'src\client\ui'

$index = Join-Path $uiRoot 'index.html'
$indexContent = @"
<!DOCTYPE html>
<html>
<head><title>ALLBOT UI</title></head>
<body>
  <h1>ALLBOT Throttle Demo</h1>
  <button id='btn'>Call Throttle API</button>
  <pre id='out'></pre>
  <script src='main.js'></script>
</body>
</html>
"@
Set-Content -Path $index -Value $indexContent -Force

$main = Join-Path $uiRoot 'main.js'
$mainContent = @"
document.getElementById('btn').onclick = async () => {
  const res = await fetch('/api/throttle');
  const data = await res.json();
  document.getElementById('out').innerText = JSON.stringify(data, null, 2);
};
"@
Set-Content -Path $main -Value $mainContent -Force

# 9. Orchestrator stub
$orch = Join-Path $Root 'src\orchestrator\orchestrator.ps1'
$orchContent = @"
param()
Write-Host 'Orchestrator starting...'
"@
Set-Content -Path $orch -Value $orchContent -Force

# 10. Bot stubs
$bots = 'OverBot','SecuBot','StreamBot','ThrottleBot','VaultBot'
foreach ($b in $bots) {
  $botPath = Join-Path $Root "src\bots\$b"
  $stub    = Join-Path $botPath "Invoke-$b.ps1"
  $stubContent = @"
param(
  [psobject]`$Payload,
  [psobject]`$Config
)

Write-Host '$b invoked with payload:' `$($Payload | ConvertTo-Json)

# TODO: implement $b logic

@{
  Bot      = '$b'
  Type     = 'Status'
  Severity = 'Info'
  Message  = 'Stub executed'
} | ConvertTo-Json
"@
  Set-Content -Path $stub -Value $stubContent -Force
  Write-Host "Created bot stub: $stub"
}

Write-Host "=== Scaffold COMPLETE! ==="
Write-Host "Next: `npm install` in '$apiRoot' and `npm start` your API."