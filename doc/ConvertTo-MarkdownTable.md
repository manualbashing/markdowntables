---
external help file: markdowntables-help.xml
Module Name: markdowntables
online version:
schema: 2.0.0
---

# ConvertTo-MarkdownTable

## SYNOPSIS
Convert PowerShell objects into a single markdown table.

## SYNTAX

```
ConvertTo-MarkdownTable [-InputObject] <Object[]> [-TableStyle <String>] [<CommonParameters>]
```

## DESCRIPTION
Objects usually contain more properties, then you would see on the console.
Use `Select-Object` to
narrow down the properties, that you want to appear in the final table.

## EXAMPLES

### Example 1
```
ps | select -Property ProcessName,Id,Handles -First 10  | ConvertTo-MarkdownTable
```

Fill a markdown table with 3 properties from the System.Diagnostics.Process object.

## PARAMETERS

### -InputObject
The collection of PowerShell objects that will be processed.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -TableStyle
The style of the resulting markdown table.
Pandoc allows: 'pipe','grid','simple' and 'multiline'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Pipe
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### A collection of PowerShell objects. (Properties should be uniform, use `Select-Object` if they are not.)
## OUTPUTS

### A string containing a markdown table, formatted according to the style specified in `-TableStyle`
## NOTES

## RELATED LINKS
