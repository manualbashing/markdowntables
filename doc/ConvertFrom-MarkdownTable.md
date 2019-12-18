---
external help file: markdowntables-help.xml
Module Name: markdowntables
online version:
schema: 2.0.0
---

# ConvertFrom-MarkdownTable

## SYNOPSIS
Converts a string containing a markdown table into power shell objects.

## SYNTAX

```
ConvertFrom-MarkdownTable [[-InputObject] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Make sure, that the string contains only a single markdown table and nothing else.

## EXAMPLES

### BEISPIEL 1
```
$serverData = ConvertFrom-MarkdownTable
```

If no parameters are specified, the markdown table is read from the current clipboard entry.

## PARAMETERS

### -InputObject
A string containing the markdown table.
Uses clipboard content if left empty.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-Clipboard)
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### A string containing a markdown table
## OUTPUTS

### A collection of powershell objects.
## NOTES

## RELATED LINKS
