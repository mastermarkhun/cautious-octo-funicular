$domain = "contoso.com"
$domainDN = "DC=contoso,DC=com"

Import-Module ActiveDirectory

$oldnames = @(
    'Tawnya Trial',
    'Julietta Johnsen',
    'Kira Kua',
    'Stephen Shofner',
    'Kristine Kubota',
    'Denis Damico',
    'Guillermo Gustavson',
    'Carmelo Cabe',
    'Danny Desir',
    'Mila Munsterman'
)

foreach ($person in $oldnames)
{
    $samaccname = $splitname[0].Substring(0,3) + $splitname[1].Substring(0,2)
    Remove-ADUser -Identity $samaccname
}

exit

$newsurname = 'Kovács'
$newnames = @(
    'Vilmos', 'Richárd', 'Kinga', 'Dominik', 'Szonja', 'Adrián', 'Zoé', 'György', 'Attila', 'Gyula', 'Adrienn'
)

$OperationsGroups = @(
    'Technical Operations',
    'Information Technologies',
    'Floor Operations',
    'Buisness Intelligence'
)

$samaccnameList = New-Object -TypeName "System.Collections.ArrayList"

foreach ($givenname in $newnames)
{
    $samaccname = $newsurname.Substring(0,3) + $givenname.Substring(0,2)
    $samaccnameList.Add($samaccname)

    $password = "User1234!"
    $secPw = ConvertTo-SecureString -String $password -AsPlainText -Force

    New-ADUser -Name "$newsurname $givenname" -GivenName $givenname -Surname $newsurname -SamAccountName $samaccname -UserPrincipalName "$samaccname@$domain" -Path "OU=$($OrgUnits|Get-Random),$domainDN" -AccountPassword $secPw -ChangePasswordAtLogon $false -Enabled $true

    "$samaccname,$password" | Out-File -FilePath "pwd_list.csv" -Append -Force
}

foreach ($group in $($OperationsGroups | where {$_ -ne 'Information Technologies'}))
{
    Add-ADGroupMember -Identity $($group -replace '\s','') -Members @($samaccnameList | Get-Random -Count 3 )
}

Add-ADGroupMember -Identity 'ITServices' -Members @($samaccnameList | Get-Random) # this will be the domain admin