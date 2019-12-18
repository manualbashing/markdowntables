<#
.SYNOPSIS
    Converts a string containing a markdown table into power shell objects.
.DESCRIPTION
    Make sure, that the string contains only a single markdown table and nothing else.
.EXAMPLE
    PS C:\> $serverData = ConvertFrom-MarkdownTable
    If no parameters are specified, the markdown table is read from the current clipboard entry.
.INPUTS
    A string containing a markdown table
.OUTPUTS
    A collection of powershell objects.
#>
function ConvertFrom-MarkdownTable
{
    [CmdletBinding()]

    Param
    (
        # A string containing the markdown table. Uses clipboard content if left empty.
        [Parameter(Position=0)]
        $InputObject=(Get-Clipboard)
    )
    <#
    As pandoc already comes with a fantastic parser for markdown, we use it!
    Pandoc needs a file to process, so we create one in the users temp folder.
    #>
    $tmpFilePath = ($env:TEMP + [guid]::NewGuid().Guid + '.md')
    $InputObject | Out-File $tmpFilePath -Encoding utf8
    $pandocJson = pandoc $tmpFilePath --to json | ConvertFrom-Json
    $pandocBlocks = $pandocJson.blocks[0].C

    <#
    Pandoc's AST json contains more information as we can stomach. For our purposes
    we simplify pandoc's AST to a simple dictionary.

    So the following table:

    | Fruit  | Color  | Shape     |
    |--------|--------|-----------|
    | Banana | Yellow | Bent      |
    | Apple  | Red    | Spherical |

    will be simplified to:

    @{
    Fruit = 'Banana'
    Color = 'Yellow'
    Shape = 'Bent'
    }

    @{
    Fruit = 'Apple'
    Color = 'Red'
    Shape = 'Spherical'
    }

    #>
    $tableDict = [ordered]@{}
    # We start with a dictionary, that contains all keys but empty values.
    foreach ($bl in $pandocBlocks[3])
    {
        $tableKey = ($bl.C.C -join ' ' -replace ' +',' ')
        $tableDict.$tableKey = ''
    }

    $tableHeader = [array]($tableDict.Keys)
    $tableBlocks = $pandocBlocks[4]
    for ($i = 0; $i -lt $tableBlocks.Count; $i++)
    {
        $tableRow = $tableBlocks[$i]

        for ($j = 0; $j -lt $tableDict.Count; $j++)
        {
            $header = $tableHeader[$j]
            $tableDict.$header = ($tableRow[$j].C.C -join ' ' -replace ' +',' ')
        }
        New-Object -TypeName psobject -Property $tableDict
    }
}