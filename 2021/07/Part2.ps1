$Crabs = (Get-Content -Path $PWD\input.txt) -split ',' -as [int[]]

$Min = ($Crabs | Measure-Object -Minimum).Minimum
$Max = ($Crabs | Measure-Object -Maximum).Maximum

$Lowest = [int32]::MaxValue
$Count = 0
<#
    Every crab movement needs to be calcualted for each position
    So for each position we move every crab around and see how expensive it is
    [Math]::Abs() gives us the absolute value so we don't need wo work with even/odd averages

    https://de.wikipedia.org/wiki/Gau%C3%9Fsche_Summenformel
    This time it is a classic Gauß sum formula:
    The sum of n to y consecutive natural numbers can be expressed as
    k(0) to n = (n(n+1))/2 or (n^2 +n) / 2 
#>
foreach ($Position in $Max..$Min) {
    $Fuel = 0
    foreach ($Crab in $Crabs) {
        $cost = [math]::Abs($Crab - $Position)
        $Fuel += ([Math]::Pow($cost,2) + $cost) / 2
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

