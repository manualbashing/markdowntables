function ConvertTo-MarkdownTable
{
    [CmdletBinding()]
    
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory, ValueFromPipeline=$true, Position=0)]
        $InputObject,

        [Parameter(Mandatory=$false)]
        [ValidateSet('pipe','grid','simple','multiline')]
        $TableStyle = 'pipe'
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