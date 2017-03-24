# Dot source Public & Private functions
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

foreach ($import in @($Public + $Private)) {

    try {   # dot-source all functions

        . $import.FullName

    } catch {

        Write-Warning -Message "Could not load function { $($import.Name) }. $_"

    } # end t/c

} # end foreach