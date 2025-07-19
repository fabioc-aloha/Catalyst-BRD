# BRD Automation Scripts
# Quick automation tools for common BRD tasks

param(
    [string]$Command = "help",
    [string]$ProjectName = "",
    [string]$Template = "",
    [string]$OutputPath = ""
)

function Show-Help {
    Write-Host "🚀 BRD Automation Tools" -ForegroundColor Green
    Write-Host ""
    Write-Host "Usage: .\BRD-Automation.ps1 -Command <command> [options]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Commands:" -ForegroundColor Cyan
    Write-Host "  new-project   Create new project structure with templates" -ForegroundColor White
    Write-Host "  new-brd       Create new BRD from template" -ForegroundColor White
    Write-Host "  status        Show project status and checklist" -ForegroundColor White
    Write-Host "  validate      Validate BRD completeness" -ForegroundColor White
    Write-Host "  templates     List available templates" -ForegroundColor White
    Write-Host "  package       Package BRD for delivery" -ForegroundColor White
    Write-Host ""
    Write-Host "Options:" -ForegroundColor Cyan
    Write-Host "  -ProjectName  Name of the project (required for new-project, new-brd)" -ForegroundColor White
    Write-Host "  -Template     Template name (required for new-brd)" -ForegroundColor White
    Write-Host "  -OutputPath   Output directory (optional)" -ForegroundColor White
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Cyan
    Write-Host "  .\BRD-Automation.ps1 -Command new-project -ProjectName 'Customer Portal Upgrade'" -ForegroundColor Gray
    Write-Host "  .\BRD-Automation.ps1 -Command new-brd -ProjectName 'Customer Portal' -Template 'technical-requirements'" -ForegroundColor Gray
    Write-Host "  .\BRD-Automation.ps1 -Command status" -ForegroundColor Gray
    Write-Host ""
}

function New-Project {
    param([string]$Name)
    
    if (-not $Name) {
        Write-Host "❌ Project name is required" -ForegroundColor Red
        return
    }
    
    $safeName = $Name -replace '[^a-zA-Z0-9\-]', '-'
    $projectPath = "projects\$safeName"
    
    Write-Host "📁 Creating project structure for: $Name" -ForegroundColor Yellow
    
    # Create project directories
    $directories = @(
        "$projectPath\brd-documents",
        "$projectPath\stakeholder-analysis",
        "$projectPath\meeting-notes",
        "$projectPath\requirements",
        "$projectPath\technical-specs",
        "$projectPath\deliverables"
    )
    
    foreach ($dir in $directories) {
        if (!(Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Host "Created: $dir" -ForegroundColor Gray
        }
    }
    
    # Create project README
    $projectReadme = @"
# $Name - Project Documentation

## Project Information
- **Project Name**: $Name
- **Created**: $(Get-Date -Format "yyyy-MM-dd")
- **Status**: Planning

## Quick Links
- [Project Charter](./brd-documents/project-charter.brd)
- [Requirements](./requirements/)
- [Meeting Notes](./meeting-notes/)
- [Deliverables](./deliverables/)

## Next Steps
- [ ] Complete project charter
- [ ] Schedule stakeholder interviews
- [ ] Define project scope
- [ ] Create project timeline

Use BRD-Automation.ps1 to generate templates and track progress.
"@
    
    $projectReadme | Out-File -FilePath "$projectPath\README.md" -Encoding UTF8
    
    Write-Host "✅ Project structure created successfully" -ForegroundColor Green
    Write-Host "📂 Project location: $projectPath" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Create project charter: .\BRD-Automation.ps1 -Command new-brd -ProjectName '$Name' -Template 'project-charter'" -ForegroundColor White
    Write-Host "2. Review the Quick Start Checklist: .\BRD-Quick-Start-Checklist.md" -ForegroundColor White
}

function New-BRD {
    param([string]$ProjectName, [string]$TemplateName)
    
    if (-not $ProjectName -or -not $TemplateName) {
        Write-Host "❌ Project name and template name are required" -ForegroundColor Red
        return
    }
    
    $templateMap = @{
        'project-charter'        = 'templates\brd-templates\project-charter.brd'
        'executive-summary'      = 'templates\brd-templates\executive-summary.brd'
        'technical-requirements' = 'templates\brd-templates\technical-requirements.brd'
        'user-stories'           = 'templates\brd-templates\user-stories-acceptance-criteria.brd'
        'risk-register'          = 'templates\brd-templates\risk-register.brd'
        'business-process'       = 'templates\brd-templates\business-process-mapping.brd'
        'data-requirements'      = 'templates\brd-templates\data-requirements-integration.brd'
    }
    
    $templatePath = $templateMap[$TemplateName]
    if (-not $templatePath -or !(Test-Path $templatePath)) {
        Write-Host "❌ Template '$TemplateName' not found" -ForegroundColor Red
        Write-Host "Available templates:" -ForegroundColor Yellow
        $templateMap.Keys | ForEach-Object { Write-Host "  - $_" -ForegroundColor White }
        return
    }
    
    $safeName = $ProjectName -replace '[^a-zA-Z0-9\-]', '-'
    $projectPath = "projects\$safeName"
    $outputFile = "$projectPath\brd-documents\$TemplateName-$(Get-Date -Format 'yyyy-MM-dd').brd"
    
    # Ensure project directory exists
    if (!(Test-Path "$projectPath\brd-documents")) {
        Write-Host "📁 Creating project directory..." -ForegroundColor Yellow
        New-Item -ItemType Directory -Path "$projectPath\brd-documents" -Force | Out-Null
    }
    
    # Copy and customize template
    Write-Host "📄 Creating BRD from template: $TemplateName" -ForegroundColor Yellow
    $content = Get-Content -Path $templatePath -Raw
    
    # Replace placeholders
    $content = $content -replace '\[Enter Project Name\]', $ProjectName
    $content = $content -replace '\[Current Date\]', (Get-Date -Format "yyyy-MM-dd")
    
    $content | Out-File -FilePath $outputFile -Encoding UTF8
    
    Write-Host "✅ BRD created successfully: $outputFile" -ForegroundColor Green
    Write-Host "📝 Next: Edit the file and fill in project-specific details" -ForegroundColor Cyan
}

function Show-Status {
    Write-Host "📊 BRD Project Status Dashboard" -ForegroundColor Green
    Write-Host ""
    
    # Check for projects
    if (Test-Path "projects") {
        $projects = Get-ChildItem -Path "projects" -Directory
        if ($projects.Count -gt 0) {
            Write-Host "🏗️ Active Projects:" -ForegroundColor Cyan
            foreach ($project in $projects) {
                Write-Host "  📂 $($project.Name)" -ForegroundColor White
                
                # Check for BRD documents
                $brdPath = "$($project.FullName)\brd-documents"
                if (Test-Path $brdPath) {
                    $brds = Get-ChildItem -Path $brdPath -Filter "*.brd"
                    Write-Host "    📋 BRD Documents: $($brds.Count)" -ForegroundColor Gray
                }
                else {
                    Write-Host "    📋 BRD Documents: 0 (run new-brd command)" -ForegroundColor Yellow
                }
                
                # Check for meeting notes
                $meetingPath = "$($project.FullName)\meeting-notes"
                if (Test-Path $meetingPath) {
                    $meetings = Get-ChildItem -Path $meetingPath -Filter "*.md"
                    Write-Host "    📝 Meeting Notes: $($meetings.Count)" -ForegroundColor Gray
                }
                else {
                    Write-Host "    📝 Meeting Notes: 0" -ForegroundColor Gray
                }
                Write-Host ""
            }
        }
        else {
            Write-Host "No projects found. Create one with:" -ForegroundColor Yellow
            Write-Host "  .\BRD-Automation.ps1 -Command new-project -ProjectName 'Your Project Name'" -ForegroundColor White
        }
    }
    else {
        Write-Host "No projects directory found. Create your first project with:" -ForegroundColor Yellow
        Write-Host "  .\BRD-Automation.ps1 -Command new-project -ProjectName 'Your Project Name'" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "📚 Template Library Status:" -ForegroundColor Cyan
    $templatePath = "templates\brd-templates"
    if (Test-Path $templatePath) {
        $templates = Get-ChildItem -Path $templatePath -Filter "*.brd"
        Write-Host "  📄 Available Templates: $($templates.Count)" -ForegroundColor White
        $templates | ForEach-Object { 
            $templateName = $_.BaseName
            Write-Host "    - $templateName" -ForegroundColor Gray
        }
    }
}

function Show-Templates {
    Write-Host "📚 Available BRD Templates" -ForegroundColor Green
    Write-Host ""
    
    $templates = @{
        'project-charter'        = 'Project Charter & Foundation - Start here for new projects'
        'executive-summary'      = 'Executive Summary - High-level business requirements'
        'technical-requirements' = 'Technical Requirements - Detailed technical specs'
        'user-stories'           = 'User Stories & Acceptance Criteria - Agile requirements'
        'risk-register'          = 'Risk Register & Mitigation - Risk management'
        'business-process'       = 'Business Process Mapping - Process analysis'
        'data-requirements'      = 'Data Requirements & Integration - Data specifications'
    }
    
    $templates.GetEnumerator() | Sort-Object Key | ForEach-Object {
        Write-Host "📄 $($_.Key)" -ForegroundColor Cyan
        Write-Host "   $($_.Value)" -ForegroundColor White
        Write-Host ""
    }
    
    Write-Host "Usage:" -ForegroundColor Yellow
    Write-Host "  .\BRD-Automation.ps1 -Command new-brd -ProjectName 'Project Name' -Template 'template-name'" -ForegroundColor White
}

function Test-BRDCompleteness {
    Write-Host "🔍 BRD Validation Tool" -ForegroundColor Green
    Write-Host ""
    
    if (!(Test-Path "projects")) {
        Write-Host "❌ No projects found to validate" -ForegroundColor Red
        return
    }
    
    $projects = Get-ChildItem -Path "projects" -Directory
    foreach ($project in $projects) {
        Write-Host "📂 Validating: $($project.Name)" -ForegroundColor Cyan
        
        $brdPath = "$($project.FullName)\brd-documents"
        $issues = @()
        $score = 0
        $maxScore = 10
        
        # Check for project charter
        if (Test-Path "$brdPath\project-charter*.brd") {
            Write-Host "  ✅ Project Charter found" -ForegroundColor Green
            $score += 2
        }
        else {
            Write-Host "  ❌ Project Charter missing" -ForegroundColor Red
            $issues += "Create project charter"
        }
        
        # Check for requirements
        $reqFiles = Get-ChildItem -Path $brdPath -Filter "*requirements*.brd" -ErrorAction SilentlyContinue
        if ($reqFiles.Count -gt 0) {
            Write-Host "  ✅ Requirements documentation found" -ForegroundColor Green
            $score += 2
        }
        else {
            Write-Host "  ❌ Requirements documentation missing" -ForegroundColor Red
            $issues += "Create requirements documentation"
        }
        
        # Check for stakeholder analysis
        $stakeholderPath = "$($project.FullName)\stakeholder-analysis"
        if (Test-Path $stakeholderPath) {
            $stakeholderFiles = Get-ChildItem -Path $stakeholderPath -Filter "*.md" -ErrorAction SilentlyContinue
            if ($stakeholderFiles.Count -gt 0) {
                Write-Host "  ✅ Stakeholder analysis present" -ForegroundColor Green
                $score += 1
            }
            else {
                Write-Host "  ⚠️ Stakeholder analysis directory empty" -ForegroundColor Yellow
                $issues += "Complete stakeholder analysis"
            }
        }
        else {
            Write-Host "  ❌ Stakeholder analysis missing" -ForegroundColor Red
            $issues += "Conduct stakeholder analysis"
        }
        
        # Check for meeting notes
        $meetingPath = "$($project.FullName)\meeting-notes"
        if (Test-Path $meetingPath) {
            $meetingFiles = Get-ChildItem -Path $meetingPath -Filter "*.md" -ErrorAction SilentlyContinue
            if ($meetingFiles.Count -gt 0) {
                Write-Host "  ✅ Meeting notes available ($($meetingFiles.Count) files)" -ForegroundColor Green
                $score += 1
            }
            else {
                Write-Host "  ⚠️ No meeting notes found" -ForegroundColor Yellow
                $issues += "Document stakeholder meetings"
            }
        }
        
        # Calculate completion percentage
        $percentage = [math]::Round(($score / $maxScore) * 100)
        
        if ($percentage -ge 80) {
            Write-Host "  🎯 Completion: $percentage% - Excellent!" -ForegroundColor Green
        }
        elseif ($percentage -ge 60) {
            Write-Host "  🎯 Completion: $percentage% - Good progress" -ForegroundColor Yellow
        }
        else {
            Write-Host "  🎯 Completion: $percentage% - Needs attention" -ForegroundColor Red
        }
        
        if ($issues.Count -gt 0) {
            Write-Host "  📋 Action Items:" -ForegroundColor Yellow
            $issues | ForEach-Object { Write-Host "    - $_" -ForegroundColor White }
        }
        
        Write-Host ""
    }
}

function New-Package {
    Write-Host "📦 BRD Package Creator" -ForegroundColor Green
    Write-Host ""
    
    if (!(Test-Path "projects")) {
        Write-Host "❌ No projects found to package" -ForegroundColor Red
        return
    }
    
    $projects = Get-ChildItem -Path "projects" -Directory
    if ($projects.Count -eq 1) {
        $selectedProject = $projects[0]
    }
    else {
        Write-Host "Available projects:" -ForegroundColor Cyan
        for ($i = 0; $i -lt $projects.Count; $i++) {
            Write-Host "  $($i + 1). $($projects[$i].Name)" -ForegroundColor White
        }
        $selection = Read-Host "Select project number (1-$($projects.Count))"
        $selectedProject = $projects[$selection - 1]
    }
    
    if ($selectedProject) {
        $packageName = "$($selectedProject.Name)-BRD-Package-$(Get-Date -Format 'yyyy-MM-dd')"
        $packagePath = "deliverables\$packageName"
        
        Write-Host "📦 Creating package: $packageName" -ForegroundColor Yellow
        
        # Create package directory
        if (!(Test-Path "deliverables")) {
            New-Item -ItemType Directory -Path "deliverables" -Force | Out-Null
        }
        if (!(Test-Path $packagePath)) {
            New-Item -ItemType Directory -Path $packagePath -Force | Out-Null
        }
        
        # Copy project files
        Copy-Item -Path "$($selectedProject.FullName)\*" -Destination $packagePath -Recurse -Force
        
        # Create package manifest
        $manifest = @"
# BRD Delivery Package
## Project: $($selectedProject.Name)
## Package Date: $(Get-Date -Format "yyyy-MM-dd HH:mm")

### Contents:
- BRD Documents
- Stakeholder Analysis
- Meeting Notes
- Requirements Documentation
- Technical Specifications

### Generated using Microsoft Internal BRD Cognitive Architecture
"@
        
        $manifest | Out-File -FilePath "$packagePath\PACKAGE-MANIFEST.md" -Encoding UTF8
        
        Write-Host "✅ Package created: $packagePath" -ForegroundColor Green
        Write-Host "📋 Package manifest: $packagePath\PACKAGE-MANIFEST.md" -ForegroundColor Cyan
    }
}

# Main script logic
switch ($Command.ToLower()) {
    "help" { Show-Help }
    "new-project" { New-Project -Name $ProjectName }
    "new-brd" { New-BRD -ProjectName $ProjectName -TemplateName $Template }
    "status" { Show-Status }
    "templates" { Show-Templates }
    "validate" { Test-BRDCompleteness }
    "package" { New-Package }
    default { 
        Write-Host "❌ Unknown command: $Command" -ForegroundColor Red
        Show-Help
    }
}
