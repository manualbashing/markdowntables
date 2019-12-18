# MarkdownTables

This PowerShell module provides functions, to convert from and to markdown tables.

 > **Before you get excited**: All magic tricks are done by pandoc, which must be installed in path.

## Installation

This module heavily relies on pandoc, to make anything happen. So obviously you need to have pandoc installed before using this module. You can download pandoc here: <https://pandoc.org/installing.html>

or use [chocolatey](https://chocolatey.org):

```
choco install pandoc
```

After pandoc is installed, you can clone this repository and put it into a valid PSModule path, like `~\Documents\WindowsPowerShell\Modules`.

## Cmdlets in this module

| Cmdlet Name                                                     | Description                                                             |
|-----------------------------------------------------------------|-------------------------------------------------------------------------|
| [ConvertFrom-MarkdownTable](doc/ConvertFrom-MarkdownTable.md)   | Converts a string containing a markdown table into power shell objects. |
| [ConvertTo-MarkdownTable](doc/ConvertTo-MarkdownTable.md)       | Convert PowerShell objects into a single markdown table.                |

## Known Issues

- ConvertFrom-MarkdownTable fails to render input correctly, if input table contains hyperlinks.
