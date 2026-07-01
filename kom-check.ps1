<#
+--------------------------------------------------------------------+
|              KOM 2.0 - CHECKLIST DE INSTALACAO                     |
|   Este script testa CADA componente e da um STATUS real da         |
|   instalacao do KOM 2.0. Nao e teoria - sao acoes de checagem.    |
+--------------------------------------------------------------------+
#>

$ROOT = $PSScriptRoot
$REPORT = @()
$TOTAL_WEIGHT = 0
$PASS_WEIGHT = 0

function Check {
    param([string]$Name, [int]$Weight, [scriptblock]$Test, [string]$Fix = "")
    $script:TOTAL_WEIGHT += $Weight
    try {
        $ok = & $Test
        if ($ok) {
            $script:PASS_WEIGHT += $Weight
            $script:REPORT += @{Name=$Name; Status="OK"; Pass=$Weight; Weight=$Weight; Fix=$Fix}
        } else {
            $script:REPORT += @{Name=$Name; Status="FAIL"; Pass=0; Weight=$Weight; Fix=$Fix}
        }
    } catch {
        $script:REPORT += @{Name=$Name; Status="FAIL"; Pass=0; Weight=$Weight; Fix=$Fix}
    }
}

function Bar {
    param([int]$Pct)
    $filled = [math]::Floor($Pct / 100 * 30)
    return ("#" * $filled) + ("." * (30 - $filled))
}

# ======================================================================
# TESTES
# ======================================================================

Check -Name "AGENTS.md (protocolo principal)" -Weight 5 -Test { Test-Path (Join-Path $ROOT "AGENTS.md") } -Fix "Arquivo AGENTS.md nao encontrado. Reinstale o KOM 2.0."
Check -Name "README.md (documentacao)" -Weight 3 -Test { Test-Path (Join-Path $ROOT "README.md") } -Fix "Arquivo README.md nao encontrado. Reinstale o KOM 2.0."
Check -Name "WELCOME.md (boas-vindas)" -Weight 3 -Test { Test-Path (Join-Path $ROOT "WELCOME.md") } -Fix "Arquivo WELCOME.md nao encontrado. Reinstale o KOM 2.0."

Check -Name "Skills OpenCode (6 habilidades)" -Weight 10 -Test {
    $s = @("kom-cycle","kom-radar","kom-registry","kom-graphify","kom-retrospect","kom-loop")
    $c = 0
    foreach ($x in $s) { if (Test-Path (Join-Path $ROOT ".opencode\skills\$x\SKILL.md")) { $c++ } }
    $c -eq 6
} -Fix "Skills faltando. Reinstale a pasta .opencode/skills/."

Check -Name "Fases do ciclo (9 documentos)" -Weight 10 -Test {
    $p = @("00-manifesto.md","01-orientacao.md","02-arquitetura.md","03-contrato.md","04-execucao.md","05-verificacao.md","06-registro.md","07-governanca.md","08-loop-engineering.md")
    $c = 0
    foreach ($x in $p) { if (Test-Path (Join-Path $ROOT "kom\$x")) { $c++ } }
    $c -eq 9
} -Fix "Documentos kom/ faltando. Reinstale a pasta kom/."

Check -Name "knowledge/registry/ (ADRs)" -Weight 5 -Test {
    $d = Join-Path $ROOT "knowledge\registry"
    (Test-Path $d) -and ((Get-ChildItem $d -Filter "*.md" -ErrorAction SilentlyContinue).Count -ge 1)
} -Fix "Diretorio knowledge/registry/ vazio. Sera populado pelo agente."

Check -Name "knowledge/lessons/ (licoes)" -Weight 3 -Test { Test-Path (Join-Path $ROOT "knowledge\lessons") } -Fix "Crie a pasta: mkdir knowledge\lessons"
Check -Name "knowledge/patterns/ (padroes)" -Weight 3 -Test { Test-Path (Join-Path $ROOT "knowledge\patterns") } -Fix "Crie a pasta: mkdir knowledge\patterns"

Check -Name "Graphify instalado (pip)" -Weight 15 -Test {
    $null = python -m graphify --version 2>&1
    $LASTEXITCODE -eq 0
} -Fix "pip install graphifyy ou python -m pip install graphifyy"

Check -Name "Grafo gerado (graph.json)" -Weight 10 -Test {
    $path = Join-Path $ROOT "graphify-out\graph.json"
    if (-not (Test-Path $path)) { return $false }
    try {
        $j = Get-Content $path -Raw | ConvertFrom-Json -ErrorAction Stop
        return ($j.nodes.Count -gt 0)
    } catch { return $false }
} -Fix "python -m graphify update . (dentro da pasta do projeto)"

Check -Name "Grafo com dados reais (+10 nos)" -Weight 10 -Test {
    $path = Join-Path $ROOT "graphify-out\graph.json"
    if (-not (Test-Path $path)) { return $false }
    try {
        $j = Get-Content $path -Raw | ConvertFrom-Json -ErrorAction Stop
        return ($j.nodes.Count -gt 10)
    } catch { return $false }
} -Fix "python -m graphify update . (o grafo atual esta vazio)"

Check -Name "Graphify query funcional" -Weight 10 -Test {
    $result = python -m graphify query "KOM 2.0" 2>&1
    $LASTEXITCODE -eq 0
} -Fix "Graphify nao responde. Reinstale: python -m pip install --upgrade graphifyy"

Check -Name "Plugin graphify.js (opencode)" -Weight 3 -Test { Test-Path (Join-Path $ROOT ".opencode\plugins\graphify.js") } -Fix "Plugin nao encontrado. Reinstale a pasta .opencode/plugins/."

Check -Name "Nenhum comando obsoleto residual" -Weight 10 -Test {
    $files = @(
        ".opencode\skills\kom-graphify\SKILL.md",
        "kom\02-arquitetura.md",
        "kom\05-verificacao.md"
    )
    $found = $false
    foreach ($f in $files) {
        $path = Join-Path $ROOT $f
        if (Test-Path $path) {
            $content = Get-Content $path -Raw
            if ($content -match "graphify affected") { $found = $true }
        }
    }
    -not $found
} -Fix "Comando antigo ainda existe nos docs. Execute: git pull."

# ======================================================================
# RESULTADO
# ======================================================================

Clear-Host

$pct = [math]::Round(($PASS_WEIGHT / $TOTAL_WEIGHT) * 100, 0)
$okCount = ($REPORT | Where-Object { $_.Status -eq "OK" }).Count
$failCount = ($REPORT | Where-Object { $_.Status -eq "FAIL" }).Count

Write-Host ""
Write-Host "+--------------------------------------------------------------------+"
Write-Host "|              KOM 2.0 - CHECKLIST DE INSTALACAO                     |"
Write-Host "+--------------------------------------------------------------------+"
Write-Host ""

if ($pct -ge 100) { Write-Host "  STATUS: INSTALACAO COMPLETA" -ForegroundColor Green }
elseif ($pct -ge 70) { Write-Host "  STATUS: QUASE LA (instalacao parcial)" -ForegroundColor Yellow }
else { Write-Host "  STATUS: INCOMPLETO (falta configurar)" -ForegroundColor Red }
Write-Host ""
Write-Host "  PROGRESSO: [" -NoNewline; Write-Host (Bar $pct) -NoNewline; Write-Host "] $pct%" -NoNewline
if ($pct -ge 100) { Write-Host "  OK" -ForegroundColor Green }
elseif ($pct -ge 70) { Write-Host "  ATENCAO" -ForegroundColor Yellow }
else { Write-Host "  FALHA" -ForegroundColor Red }
Write-Host ""
Write-Host "  $okCount de $($okCount + $failCount) componentes funcionando"
Write-Host ""
Write-Host "  COMPONENTE                       STATUS  PONTOS"
Write-Host "  " ("-" * 52)
foreach ($r in $REPORT) {
    $name = $r.Name.PadRight(35)
    $status = if ($r.Status -eq "OK") { "  [OK]  " } else { " [FALHA] " }
    $pts = "$($r.Pass)/$($r.Weight)".PadLeft(7)
    $color = if ($r.Status -eq "OK") { "Green" } else { "Red" }
    Write-Host "  $name$status$pts" -ForegroundColor $color
}
Write-Host ""
Write-Host "  LEGENDA: OK = funcionando | FALHA = precisa configurar"
Write-Host ""

$failed = $REPORT | Where-Object { $_.Status -eq "FAIL" }
if ($failed.Count -gt 0) {
    Write-Host "  ACOES NECESSARIAS:" -ForegroundColor Yellow
    Write-Host "  " ("-" * 52)
    foreach ($f in $failed) {
        Write-Host "  [FALHA] $($f.Name)" -ForegroundColor Red
        if ($f.Fix) { Write-Host "     -> $($f.Fix)" }
        Write-Host ""
    }
}

if ($pct -ge 100) {
    Write-Host "  KOM 2.0 INSTALACAO COMPLETA E FUNCIONAL!" -ForegroundColor Green
    Write-Host "  Todas as verificacoes passaram." -ForegroundColor Green
    Write-Host ""
    Write-Host "  PROXIMOS PASSOS:" -ForegroundColor Cyan
    Write-Host "  1. Abra o OpenCode (ou Claude Code, Codex, etc.)" -ForegroundColor Cyan
    Write-Host "  2. O WELCOME.md sera exibido automaticamente" -ForegroundColor Cyan
    Write-Host "  3. Peca: 'me ajude com [sua tarefa]'" -ForegroundColor Cyan
} elseif ($pct -ge 70) {
    Write-Host "  Instalacao parcial - revise os itens com FALHA" -ForegroundColor Yellow
    Write-Host "  KOM 2.0 funciona sem Graphify, mas o grafo e recomendado." -ForegroundColor Yellow
} else {
    Write-Host "  Instalacao incompleta - corrija os itens com FALHA" -ForegroundColor Red
    Write-Host "  Siga as instrucoes em ACOES NECESSARIAS acima." -ForegroundColor Red
}

Write-Host ""
Write-Host "  DICA: para corrigir automaticamente, peca ao agente:" -ForegroundColor Cyan
Write-Host "    configure o KOM 2.0 completo para mim" -ForegroundColor Cyan
Write-Host "    instale o graphify e gere o grafo" -ForegroundColor Cyan
Write-Host ""
