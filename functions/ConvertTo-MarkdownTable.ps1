<#
.SYNOPSIS
    Convert PowerShell objects into a single markdown table.
.DESCRIPTION
    Objects usually contain more properties, then you would see on the console. Use `Select-Object` to
    narrow down the properties, that you want to appear in the final table.
.EXAMPLE
    PS C:\> ps | select -Property ProcessName,Id,Handles -First 10  | ConvertTo-MarkdownTable
    Fill a markdown table with 3 properties from the System.Diagnostics.Process object.
.INPUTS
    A collection of PowerShell objects. (Properties should be uniform, use `Select-Object` if they are not.)
.OUTPUTS
    A string containing a markdown table, formatted according to the style specified in `-TableStyle`
#>
function ConvertTo-MarkdownTable
{
    [CmdletBinding()]

    Param
    (
        # The collection of PowerShell objects that will be processed.
        [Parameter(Mandatory, ValueFromPipeline=$true, Position=0)]
        [System.Object[]]$InputObject,

        # The style of the resulting markdown table. Pandoc allows: 'pipe','grid','simple' and 'multiline'
        [Parameter(Mandatory=$false)]
        [ValidateSet('pipe','grid','simple','multiline')]
        [string]$TableStyle = 'pipe'
    )
    Begin
    {
        $objCollection = @()
    }
    Process
    {
        # Preserve obj collection when passed through pipeline.
        foreach ($obj in $InputObject)
        {
            $objCollection += $obj
        }
    }
    End
    {
        $tmpFilePath = ($env:TEMP + [guid]::NewGuid().Guid + '.html')
        $objCollection | ConvertTo-Html -Fragment | Out-File $tmpFilePath -Encoding utf8
        pandoc $tmpFilePath --to "markdown_strict+${TableStyle}_tables"
    }
}