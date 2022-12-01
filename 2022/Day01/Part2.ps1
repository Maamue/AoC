$calories = (Get-Content -Path $PWD/input.txt) -as [string[]]
$max, $min, $sum = 0, 0, 0

$sums = [System.Collections.Generic.List[int]]::new()

$calories | ForEach-Object {
    if ( [string]::IsNullOrWhiteSpace($_) ) {
        $sums.Add($sum)
        $sum = 0
    } else {
        $sum += [int]$_
    }
}
(($sums | Sort-Object -Descending)[0..2] | Measure-Object -Sum).Sum