# Downloads the workshop screenshots from the original site into
# docs/images/<section>/... grouped by menu item and section.
#
# Usage:  pwsh ./scripts/download-images.ps1
#         powershell -ExecutionPolicy Bypass -File ./scripts/download-images.ps1

$ErrorActionPreference = 'Continue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$base    = 'http://cl-wil.s3-website.eu-central-1.amazonaws.com/25e51379e6/assets/'
$repo    = Split-Path -Parent $PSScriptRoot
$imgRoot = Join-Path $repo 'docs\images'

$items = New-Object System.Collections.Generic.List[object]
function Add-Img([string]$src, [string]$dst) {
    $script:items.Add([pscustomobject]@{ Src = $src; Dst = $dst })
}

# --- 1-Prepare the Lab Environment ---------------------------------------
Add-Img '1-1.png' 'prepare-lab/access-via-web-browser/1-1.png'
Add-Img '1-2.png' 'prepare-lab/access-using-vpn/1-2.png'
Add-Img '1-3.png' 'prepare-lab/access-using-vpn/1-3.png'

# --- 2-Lab Tasks ----------------------------------------------------------
Add-Img 'acmet1.png' 'lab-tasks/tasks-summary/acmet1.png'
Add-Img '2-1.png'    'lab-tasks/tips/2-1.png'

# Task 1 - connectivity test
Add-Img 'topology%28ACME%29.png' 'lab-tasks/task-1-connectivity-test/topology-acme.png'
2..5   | ForEach-Object { Add-Img "2-$_.png" "lab-tasks/task-1-connectivity-test/2-$_.png" }

# Task 2 - troubleshoot through FTD CLI
6..33  | ForEach-Object { Add-Img "2-$_.png" "lab-tasks/task-2-troubleshoot-ftd-cli/2-$_.png" }

# Task 3 - allow inside to outside
34..42 | ForEach-Object { Add-Img "2-$_.png" "lab-tasks/task-3-inside-to-outside/2-$_.png" }

# Task 4 - allow outside to inside
43..50 | ForEach-Object { Add-Img "2-$_.png" "lab-tasks/task-4-outside-to-inside/2-$_.png" }

# Task 5 - IPS policy
51..62 | ForEach-Object { Add-Img "2-$_.png" "lab-tasks/task-5-ips-policy/2-$_.png" }

# Task 6 - Site-to-Site VPN
1..31  | ForEach-Object { Add-Img "v$_.png" "lab-tasks/task-6-site-to-site-vpn/v$_.png" }
Add-Img 'v42.png' 'lab-tasks/task-6-site-to-site-vpn/v42.png'

# Task 7 - File policy
Add-Img 'filepolicy.png' 'lab-tasks/task-7-file-policy/filepolicy.png'
35..41 | ForEach-Object { Add-Img "v$_.png" "lab-tasks/task-7-file-policy/v$_.png" }

# Kali linux tcpdump
32..33 | ForEach-Object { Add-Img "v$_.png" "lab-tasks/tcpdump/v$_.png" }

# Host web server in Kali linux
Add-Img 'v34.png' 'lab-tasks/host-web-server/v34.png'

# --- Theory ---------------------------------------------------------------
'17', '18', '19'                                     | ForEach-Object { Add-Img "t$_.png" "theory/ftd-overview/t$_.png" }
Add-Img 't1.png' 'theory/show-asp-drop/t1.png'
'14', '15', '16', '2', '3', '41', '42', '43', '44', '5', '6' | ForEach-Object { Add-Img "t$_.png" "theory/packet-tracer/t$_.png" }
Add-Img 't7.png' 'theory/access-control-policy/t7.png'
'9', '10', '11', '12'                                | ForEach-Object { Add-Img "t$_.png" "theory/nat/t$_.png" }
Add-Img 't13.png' 'theory/vpn/t13.png'

# --- Topologies -----------------------------------------------------------
Add-Img 'topology%28lab%29.png' 'topologies/topology-lab.png'
Add-Img 'topology.png'          'topologies/topology.png'

# --- Download -------------------------------------------------------------
$ok = 0
$fail = New-Object System.Collections.Generic.List[string]
foreach ($it in $items) {
    $url = $base + $it.Src
    $out = Join-Path $imgRoot ($it.Dst -replace '/', '\')
    $dir = Split-Path -Parent $out
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -TimeoutSec 60
        $ok++
    }
    catch {
        $fail.Add($it.Dst)
    }
}

Write-Host ""
Write-Host "Downloaded $ok / $($items.Count).  Failed: $($fail.Count)"
if ($fail.Count -gt 0) {
    Write-Host "Failed items:"
    $fail | ForEach-Object { Write-Host "  - $_" }
}
