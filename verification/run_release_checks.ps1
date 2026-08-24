$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location -LiteralPath $repoRoot

function Resolve-Executable {
    param(
        [Parameter(Mandatory = $true)][string[]]$Names,
        [Parameter(Mandatory = $true)][string[]]$Fallbacks
    )

    foreach ($name in $Names) {
        $command = Get-Command $name -ErrorAction SilentlyContinue
        if ($null -ne $command) {
            return $command.Source
        }
    }
    foreach ($fallback in $Fallbacks) {
        if (Test-Path -LiteralPath $fallback) {
            return $fallback
        }
    }
    throw "Required executable not found: $($Names -join ', ')"
}

function Invoke-Checked {
    param(
        [Parameter(Mandatory = $true)][string]$Label,
        [Parameter(Mandatory = $true)][string]$Executable,
        [Parameter(Mandatory = $true)][string[]]$Arguments
    )

    Write-Output "=== $Label ==="
    & $Executable @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Label failed with exit code $LASTEXITCODE"
    }
}

$userProfile = $env:USERPROFILE
$pythonFallbacks = @()
$lakeFallbacks = @()
if (-not [string]::IsNullOrWhiteSpace($userProfile)) {
    $pythonFallbacks += (Join-Path $userProfile ".local\bin\python3.14.exe")
    $lakeFallbacks += (Join-Path $userProfile ".elan\bin\lake.exe")
}

$python = Resolve-Executable -Names @("python", "python3") -Fallbacks $pythonFallbacks
$lake = Resolve-Executable -Names @("lake") -Fallbacks $lakeFallbacks

Invoke-Checked "L14 finite regression" $python @(
    "-B", "verification\trajectory_normal_form_regression.py"
)
Invoke-Checked "YAH adjacent-edge certificate" $python @(
    "-B", "verification\yah_2local_edge_no_go.py"
)
Invoke-Checked "YAH two-state certificate" $python @(
    "-B", "verification\yah_two_state_semantic_label_no_go.py"
)
Invoke-Checked "YAH scalar full certificate" $python @(
    "-S", "-B", "verification\yah_two_state_scalar_arctic_full_no_start.py"
)
Invoke-Checked "YAH scalar top certificates" $python @(
    "-S", "-B", "verification\yah_scalar_arctic_top\verify_top_certificates.py"
)
Invoke-Checked "Bounded max-C cycle diagnostic" $python @(
    "-B", "verification\disproof_cycle_search.py"
)
Invoke-Checked "Lean umbrella build" $lake @("build")
Invoke-Checked "Lean two-pump module" $lake @(
    "env", "lean", "lean\CollatzWork\Disproof\TwoPumpDependency.lean"
)
Invoke-Checked "Lean branching-center core" $lake @(
    "env", "lean", "lean\CollatzWork\Disproof\BranchingCenter.lean"
)
Invoke-Checked "Lean finite-residue first-integral core" $lake @(
    "env", "lean", "lean\CollatzWork\Disproof\FiniteResidueFirstIntegral.lean"
)
Invoke-Checked "Lean polynomial-ratchet core" $lake @(
    "env", "lean", "lean\CollatzWork\Disproof\PolynomialRatchet.lean"
)
Invoke-Checked "Repository note graph" $python @(
    "-B", "verification\check_note_graph.py"
)

Write-Output "RELEASE_CHECKS = PASS"
