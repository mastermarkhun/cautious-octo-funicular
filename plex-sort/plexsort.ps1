param (
    [string]$folder,
    [string]$plexfolder
)

$items = Get-ChildItem $folder | Sort-Object -Property "CreationTime"

foreach ($item in $items)
{
    Get-ItemProperty -Path $item | %{Write-Verbose -Verbose "$($_.CreationTime)`t$item"}

    Move-Item -Path $item -Destination $plexfolder

    Start-Sleep -Seconds 30
}