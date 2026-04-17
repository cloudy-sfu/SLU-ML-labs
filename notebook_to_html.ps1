# Ref: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item
# Ref: https://nbconvert.readthedocs.io/en/latest/usage.html

$outDir = "docs"
$extension = ".ipynb" # Change to .md, .docx, etc., based on your actual files

# 1. Create the docs/ folder if it doesn't exist
if (-not (Test-Path -Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
    Write-Host "Created directory: $outDir"
}

# 2. Loop through files lab_1 to lab_10
for ($i = 1; $i -le 10; $i++) {
    $fileName = "lab_$i$extension"

    # 3. Verify file exists before attempting conversion
    if (Test-Path -Path $fileName) {
        Write-Host "Converting $fileName to HTML..."

        # --- CONVERSION COMMANDS ---
        # Option A: Jupyter Notebooks (Requires Jupyter installed)
        python -m jupyter nbconvert --to html $fileName --output-dir $outDir

        # Option B: Markdown files using Pandoc (Requires Pandoc installed)
        # Uncomment the line below and comment out Option A if using Markdown
        # pandoc $fileName -f markdown -t html -s -o "$outDir/lab_$i.html"

    } else {
        Write-Host "Warning: $fileName not found. Skipping..." -ForegroundColor Yellow
    }
}

Write-Host "Batch export complete." -ForegroundColor Green
