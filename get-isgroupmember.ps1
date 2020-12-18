function get-isgroupmember {
param(
[Parameter (Mandatory)][string]$objclass,
[Parameter (Mandatory)][string]$group
)
$ou = "LDAP://DC=<dom>,DC=<dom>"
$objsearcher = New-Object System.DirectoryServices.DirectorySearcher
$objsearcher.SearchRoot = New-Object System.DirectoryServices.DirectoryEntry($ou)
$objsearcher.Filter = "(&(objectCategory=group)(cn=$($group)))"
$temp = $objsearcher.FindOne()
if ($temp.count -eq 1){
$objsearcher.SearchScope = "Subtree"
$objsearcher.PageSize = 10
$objsearcher.Filter = "(&(objectClass=$($objclass))(Name=$($env:COMPUTERNAME))(memberof=$($temp.Properties.distinguishedname)))"
$res = $objsearcher.FindOne()
if ($res.Count -eq 0){
return $false
}
else {
return $true
}
}
else {
return $null
}
}
