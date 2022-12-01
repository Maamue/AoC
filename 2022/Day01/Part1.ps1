$calories = (Get-Content -Path $PWD/input.txt) -as [string[]]
$max, $min, $sum = 0, 0, 0

$calories | ForEach-Object {
    if ( -not [string]::IsNullOrWhiteSpace($_) ) {
        $sum += [int]$_ 
        if ($sum -gt $max) { 
            $max = $sum
        } 
    } else {$sum = 0}
}
$max