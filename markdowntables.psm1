Get-ChildItem "$PSScriptRoot\functions\*.ps1" |
    ForEach-Object { . $_.FullName }

Export-ModuleMember -Function @(
    'ConvertFrom-MarkdownTable',
    'ConvertTo-MarkdownTable'
    )
