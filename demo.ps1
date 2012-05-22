Add-Type -Path .\MarkdownSharp.dll
$mds = new-object MarkdownSharp.Markdown
$mds.AutoHyperlink = $true
$mds.AutoNewLines = $true

# loop through each dir in eample
foreach ($dir in (ls example))
{
    # make an empty "hashtable"
    $props = @{}

    # get each line of props,               and split each line on ':'    and assign to the props hashtable
    get-content "example\$dir\props.txt" | % { ($k,$v) = $_.split(": ",2); $props[$k] = $v;  }

    # get the content of details.md in one big string
    $detailsText = get-content "example\$dir\details.md"
    $detailsText =  [string]::join("`n", $detailsText)
    
    # convert to html
    $html = $mds.transform($detailsText)
    
    # stick it onto the props hashtable
    $props.details = $html

    # echo out the current value
    $props

    # TODO - add props to the xls file
}
