try {
    $pandocVersion = pandoc --version | Select-Object -First 1
    Write-Verbose "Found $pandocVersion"
}
catch [System.Management.Automation.CommandNotFoundException] {

    "Module cannot be imported: Pandoc was not found in path." +
    " Get your fix here: <https://pandoc.org/installing.html>" |
        Write-Error
    break
}

Get-ChildItem "$PSScriptRoot\functions\*.ps1" |
    ForEach-Object { . $_.FullName }

Export-ModuleMember -Function @(
    'ConvertFrom-MarkdownTable',
    'ConvertTo-MarkdownTable'
    )
