param (
    [string]$folder,
    [string]$plexfolder
)

$items = Get-ChildItem $folder | Sort-Object -Property "CreationTime"

foreach ($item in $items)
{
    Write-Verbose -Verbose "$($item.CreationTime)`t$item"

    Move-Item -LiteralPath $item.FullName -Destination $plexfolder -Force -Verbose

    Start-Sleep -Seconds 30
}