function ConvertFrom-MarkdownTable
{
    [CmdletBinding()]
    
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Position=0)]
        $InputObject=(Get-Clipboard)
    )
    # Use pandoc for markdown parsing
    $tmpFilePath = ($env:TEMP + [guid]::NewGuid().Guid + '.md')
    $InputObject | Out-File $tmpFilePath -Encoding utf8
    $pandocJson = pandoc $tmpFilePath --to json | ConvertFrom-Json
    $pandocBlocks = $pandocJson.blocks[0].c

    # Simplify pandoc AST json to a simple dictionary
    $tableDict = [ordered]@{}
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