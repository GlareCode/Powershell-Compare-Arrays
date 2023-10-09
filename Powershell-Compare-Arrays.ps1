<# 
    refs
    https://stackoverflow.com/questions/32128963/how-can-i-find-the-index-of-a-string-array-element-using-the-arrayfindindex
    https://stackoverflow.com/questions/21209946/array-find-on-powershell-array
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7.3
    https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-09?view=powershell-7.3
    https://learn.microsoft.com/en-us/dotnet/api/system.string.isnullorwhitespace?view=net-7.0
#>


# Our Array of Currently installed software.
[collections.Arraylist]$CurrentSoftware = Get-Package | Where-Object {$_.providername -ne "msu"} | Select-Object -ExpandProperty Name


# Our Array of software to find.
[collections.Arraylist]$CompareList = Ninja-Property-Options windowsSoftware


<#
    Testing example -
    Comment out the above $CompareList and -
    use this one to test without Ninja.

$CompareList = @(
    "7-Zip 23.01 (x64)",
    "Inkscape",
    "Google Earth Pro",
    "Wireshark 3.4.5 64-bit",
    "SAPIEN ScriptMerge 2020",
    "NVIDIA GeForce Experience 3.22.0.32",
    "NVIDIA GeForce", "PhotoShop"
    )

#>

# Our empty hashtable to populate with comparison results.
$Result = New-Object System.Data.DataTable
[void]$Result.Columns.Add("Software Found")
[void]$Result.Columns.Add("Software Compared")

# Our parsing and populating the empty hashtable adventure
for($i = 0; $i -lt $CompareList.Count; $i ++){
    #Try .contains method first
    $TryFirst = $CurrentSoftware.Contains($CompareList[$i])

    # If .Contains is false, try the 'where' tactic, just in case.
    if($TryFirst -eq $false){
        $TrySecond = $currentsoftware | Where-Object {$_ -Match $CompareList[$i]}
        [void]$Result.Rows.Add($CompareList[$i], -Not[string]::IsNullOrEmpty($TrySecond))
    }else{
        [void]$Result.Rows.Add($CompareList[$i], $TryFirst)
    }
}

$Result

