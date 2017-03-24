function Get-VsanHcl {

    <#
.SYNOPSIS
    Get VMware's most recent VSAN Hardware Compatability List (HCL)
.DESCRIPTION
    Get VMware's most recent VSAN Hardware Compatability List (HCL) which can be used to upload into an environment that may not have external access.

    This function will allow you to explore the contents of the HCL in the CLI
.PARAMETER FilePath
    Path and name of file you wish to save the information to. The default is $HOME\Downloads\vmware-vsan-hcl_yyyyMMdd.json
.PARAMETER Component
    Type of component you wish to return. Valid Values are 'Controller', 'HDD', 'SSD' or 'All'. The default value is 'All'
.INPUTS
    System.String
.OUTPUTS
    System.Management.Automation.PSCustomObject
.EXAMPLE
    Get-VsanHcl -Verbose | Out-GridView
.EXAMPLE
    Get-VsanHcl -Verbose
.NOTES
    Author: Kevin Kirkpatrick
    Contact: GitHub.com/vScripter
    Last Updated: 20170324
    Last Updated By: K. Kirkpatrick
    Last Update Notes:
    - General syntax updates

#>

    [OutputType([System.Management.Automation.PSCustomObject])]
    [cmdletbinding(DefaultParameterSetName = 'Default')]
    param (
        [parameter(
            Mandatory = $false,
            Position = 1,
            ParameterSetName = 'default')]
        [validatescript( {Test-Path -LiteralPath (Split-Path -LiteralPath $_)})]
        [System.String]
        $FilePath = "$PSScriptRoot\..\Inputs\vsan-hcl.json",

        [parameter(
            Mandatory = $false,
            Position = 1,
            ParameterSetName = 'default')]
        [ValidateSet("Controller", "HDD", "SSD", "All")]
        [System.String]
        $Component = 'All'
    )

    BEGIN {

        Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Processing Started"

    } # end END block

    PROCESS {

        switch ($Component) {

            'Controller' {

                Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Opening file { $FilePath }"

                try {

                    (Get-Content -Path $FilePath -Raw -ErrorAction 'Stop' | ConvertFrom-Json -ErrorAction 'Stop').Data.controller

                } catch {

                    Write-Warning -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)][ERROR] Could not read file { $FilePath }. You may need to run 'Save-VsanHcl' in order to save the HCL Database file. $_"

                } # end try/catch

            } # end Controller

            'HDD' {

                Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Opening file { $FilePath }"

                try {

                    (Get-Content -Path $FilePath -Raw -ErrorAction 'Stop' | ConvertFrom-Json -ErrorAction 'Stop').Data.hdd

                } catch {

                    Write-Warning -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)][ERROR] Could not read file { $FilePath }. You may need to run 'Save-VsanHcl' in order to save the HCL Database file. $_"

                } # end try/catch

            } # end HDD

            'SSD' {

                Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Opening file { $FilePath }"

                try {

                    (Get-Content -Path $FilePath -Raw -ErrorAction 'Stop' | ConvertFrom-Json -ErrorAction 'Stop').Data.ssd

                } catch {

                    Write-Warning -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)][ERROR] Could not read file { $FilePath }. You may need to run 'Save-VsanHcl' in order to save the HCL Database file. $_"

                } # end try/catch

            } # end SSD

            'All' {

                Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Opening file { $FilePath }"

                try {

                    (Get-Content -Path $FilePath -Raw -ErrorAction 'Stop' | ConvertFrom-Json -ErrorAction 'Stop').Data

                } catch {

                    Write-Warning -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)][ERROR] Could not read file { $FilePath }. You may need to run 'Save-VsanHcl' in order to save the HCL Database file. $_"

                } # end try/catch

            } # end All

        } # end switch

    } # end PROCESS block

    END {

        Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Processing Complete"

    } # end END block

} # end function Get-VsanHcl