$domain = "contoso.com"
$domainDN = "DC=contoso,DC=com"

$names = @(
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

$OrgUnits = @(
    'Sales and Marketing',
    'Product Management',
    'Operations',
    'Legal Division',
    'Finance Division',
    'New products Division'
)

$OperationsGroups = @(
    'Technical Operations',
    'Information Technologies',
    'Floor Operations',
    'Buisness Intelligence'
)

$InformationTechnologiesGroups = @(
    'Quality Assurance',
    'Development',
    'Platform Development',
    'IT Services'
)

$DomainAdminGroups = @(
    'Global Admins',
    'Operation Admins',
    'Services',
    'Temp'
)

Import-Module ActiveDirectory
Add-Type -AssemblyName 'System.Web'

$OrgUnits | foreach {
    New-ADOrganizationalUnit -Name $_ -Path $domainDN
}

foreach ($person in $names)
{
    $splitname = $person.Split(" ")
    $samaccname = $splitname[0].Substring(0,3) + $splitname[1].Substring(0,2)

    $length = 10 ## characters
    $nonAlphaChars = 0
    $password = [System.Web.Security.Membership]::GeneratePassword($length, $nonAlphaChars)
    $secPw = ConvertTo-SecureString -String $password -AsPlainText -Force

    New-ADUser -Name $person -GivenName $splitname[0] -Surname $splitname[1] -SamAccountName $samaccname -UserPrincipalName "$samaccname@$domain" -Path "OU=$($OrgUnits|Get-Random),$domainDN" -AccountPassword $secPw -ChangePasswordAtLogon $false -Enabled $true

    "$samaccname,$password" | Out-File -FilePath "pwd.csv" -Append -Force
}

foreach ($groupname in $OperationsGroups)
{
    $samaccname = $groupname -replace '\s',''

    New-ADGroup -Name $groupname -SamAccountName $samaccname -GroupCategory Security -GroupScope Global -DisplayName $groupname -Path "OU=Operations,$domainDN"
}

foreach ($groupname in $InformationTechnologiesGroups)
{
    $samaccname = $groupname -replace '\s',''

    New-ADGroup -Name $groupname -SamAccountName $samaccname -GroupCategory Security -GroupScope Global -DisplayName $groupname -Path "CN=Users,$domainDN"
}

foreach ($groupname in $DomainAdminGroups)
{
    $samaccname = $groupname -replace '\s',''

    New-ADGroup -Name $groupname -SamAccountName $samaccname -GroupCategory Security -GroupScope Global -DisplayName $groupname -Path "CN=Users,$domainDN"
}

Add-ADGroupMember -Identity 'InformationTechnologies' -Members $($InformationTechnologiesGroups | foreach {$_ -replace '\s',''})

foreach ($group in $($OperationsGroups | where {$_ -ne 'Information Technologies'}))
{
    Add-ADGroupMember -Identity $($group -replace '\s','') -Members @($names | Get-Random -Count 3 | foreach {$_.split(" ")[0].Substring(0,3) + $_.split(" ")[1].Substring(0,2)})
}

Add-ADGroupMember -Identity 'ITServices' -Members @($names | Get-Random | foreach {$splitname[0].Substring(0,3) + $splitname[1].Substring(0,2)})

Add-ADGroupMember -Identity 'Domain Admins' -Members 'InformationTechnologies'
Add-ADGroupMember -Identity 'Domain Admins' -Members $($DomainAdminGroups | foreach {$_ -replace '\s',''})