function Save-VsanHcl {

<#
.SYNOPSIS
    Gets and saves VMware's most recent VSAN Hardware Compatability List (HCL)
.DESCRIPTION
    Gets and saves VMware's most recent VSAN Hardware Compatability List (HCL), which can be used to upload into an environment that may not have external access.
.PARAMETER URI
    Web URI where the VMware provided HCL can be downloaded from
.PARAMETER OutputPath
    Path and name of file you wish to save the information to. The default is $HOME\Downloads\vmware-vsan-hcl_yyyyMMdd.json
.INPUTS
    System.String
.OUTPUTS
    System.Management.Automation.PSCustomObject
.EXAMPLE
    Save-VsanHcl -Verbose
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
            Position = 0,
            ParameterSetName = 'default')]
        [validatescript({ (Invoke-WebRequest -Uri $_).StatusCode -eq 200 })]
        [System.String]
        $URI = 'http://partnerweb.vmware.com/service/vsan/all.json',

        [parameter(
            Mandatory = $false,
            Position = 1,
            ParameterSetName = 'default')]
        [System.String]
        $OutputFile = "$PSScriptRoot\..\Inputs\vsan-hcl.json"
    )

    BEGIN {

        Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Processing Started"

    } # end END block

    PROCESS {

        Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Exporting source data from URI { $URI }"
        try {

            (Invoke-WebRequest -Uri $URI -ErrorAction 'Stop').Content | Out-File $OutputFile -Encoding utf8 -ErrorAction 'Stop' -Force

            [PSCustomObject] @{
                ExportPath = $OutputFile
                URI        = $URI
                Status     = 'Success'
            } # end [PSCustomObject]

        } catch {

            Write-Warning -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)][ERROR] Could not export source data from URI { $URI }. $_"

        } # end try/catch

    } # end PROCESS block

    END {

        Write-Verbose -Message "[$($PSCmdlet.MyInvocation.MyCommand.Name)] Processing Complete"

    } # end END block

} # end function Save-VsanHcl