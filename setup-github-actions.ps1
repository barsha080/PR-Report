# GitHub Actions Setup Script for PowerShell
# (c) 2026 Qorix
#
# This script helps you copy GitHub Actions workflow files to your repository

param(
    [Parameter(Mandatory=$true, HelpMessage="Path to your GitHub repository")]
    [string]$RepositoryPath
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GitHub Actions Setup for PR Dashboard" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$sourcePath = Join-Path $PSScriptRoot ".github\workflows"
$targetPath = Join-Path $RepositoryPath ".github\workflows"

Write-Host "Target repository: $RepositoryPath"
Write-Host "Source path: $sourcePath"
Write-Host ""

# Check if repository path exists
if (-not (Test-Path $RepositoryPath)) {
    Write-Host "Error: Repository path does not exist!" -ForegroundColor Red
    Write-Host "Path: $RepositoryPath"
    exit 1
}

# Create .github\workflows directory if it doesn't exist
if (-not (Test-Path $targetPath)) {
    Write-Host "Creating .github\workflows directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
}

# Copy workflow files
Write-Host ""
Write-Host "Copying workflow files..." -ForegroundColor Cyan
Write-Host ""

$files = @(
    @{Name="collect-pr-data.yml"; Source="$sourcePath\collect-pr-data.yml"},
    @{Name="sync-all-prs.yml"; Source="$sourcePath\sync-all-prs.yml"},
    @{Name="pr-quality-check.yml"; Source="$PSScriptRoot\.github-workflows-pr-quality-check.yml"}
)

$successCount = 0
$totalCount = $files.Count

for ($i = 0; $i -lt $files.Count; $i++) {
    $file = $files[$i]
    $number = $i + 1
    
    if (Test-Path $file.Source) {
        Write-Host "[$number/$totalCount] Copying $($file.Name)..." -NoNewline
        try {
            $destFile = Join-Path $targetPath $file.Name
            Copy-Item $file.Source $destFile -Force
            Write-Host " ✓ Success" -ForegroundColor Green
            $successCount++
        } catch {
            Write-Host " ✗ Failed" -ForegroundColor Red
            Write-Host "  Error: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "[$number/$totalCount] ✗ $($file.Name) not found at $($file.Source)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Complete! ($successCount/$totalCount files copied)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($successCount -eq $totalCount) {
    Write-Host "Next steps:" -ForegroundColor Green
    Write-Host ""
    Write-Host "  1. Navigate to your repository:" -ForegroundColor White
    Write-Host "     cd `"$RepositoryPath`"" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  2. Commit and push the workflow files:" -ForegroundColor White
    Write-Host "     git add .github\workflows\" -ForegroundColor Gray
    Write-Host "     git commit -m `"Add PR Report Card automation`"" -ForegroundColor Gray
    Write-Host "     git push origin main" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  3. Verify in GitHub:" -ForegroundColor White
    Write-Host "     - Go to your repository on GitHub" -ForegroundColor Gray
    Write-Host "     - Click the 'Actions' tab" -ForegroundColor Gray
    Write-Host "     - You should see 3 new workflows" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  4. Test it:" -ForegroundColor White
    Write-Host "     - Create a new PR" -ForegroundColor Gray
    Write-Host "     - Check Actions tab for workflow runs" -ForegroundColor Gray
    Write-Host "     - Download the artifact and import to dashboard" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host "Some files failed to copy. Please check the errors above." -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "For detailed instructions, see:" -ForegroundColor White
Write-Host "  $(Join-Path $PSScriptRoot 'GITHUB-ACTIONS-SETUP.md')" -ForegroundColor Gray
Write-Host ""

# Offer to commit automatically
if ($successCount -eq $totalCount) {
    $commit = Read-Host "Would you like to commit and push now? (y/n)"
    
    if ($commit -eq 'y' -or $commit -eq 'Y') {
        Push-Location $RepositoryPath
        
        Write-Host ""
        Write-Host "Running git commands..." -ForegroundColor Cyan
        
        git add .github\workflows\
        git commit -m "Add PR Report Card automation workflows"
        
        $push = Read-Host "Push to remote? (y/n)"
        if ($push -eq 'y' -or $push -eq 'Y') {
            git push
            Write-Host ""
            Write-Host "✓ Workflows pushed to GitHub!" -ForegroundColor Green
            Write-Host "Check the Actions tab in your repository." -ForegroundColor Green
        }
        
        Pop-Location
    }
}
