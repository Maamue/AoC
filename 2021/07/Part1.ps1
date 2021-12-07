$Crabs = (Get-Content -Path $PWD\input.txt) -split ',' -as [int[]]

$Min = ($Crabs | Measure-Object -Minimum).Minimum
$Max = ($Crabs | Measure-Object -Maximum).Maximum

$Lowest = [int32]::MaxValue
$Count = 0
<#
    Every crab movement needs to be calcualted for each position
    So for each position we move every crab around and see how expensive it is
    [Math]::Abs() gives us the absolute value so we don't need wo work with even/odd averages
#>
foreach ($Position in $Max..$Min) {
    $Fuel = 0
    foreach ($Crab in $Crabs) {
        $Fuel += [math]::Abs($Crab - $Position)
    }
    if ($Fuel -lt $Lowest) {
        $Lowest = $Fuel
        $Count = 0
    } else { $Count++ }
}
[PSCustomObject]@{
    Position = $Count
    Fuel     = $Lowest
}

