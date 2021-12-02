$sonar = Get-Content -Path $PSScriptRoot\input.txt

$depth, $horizontal, $sum = 0
foreach ($change in $sonar) {
    switch -Regex ($change) {
        '^f' { $horizontal += [int]($change -replace '[^0-9]', '') }
        '^d' { $depth += [int]($change -replace '[^0-9]', '') }
        '^u' { $depth -= [int]($change -replace '[^0-9]', '') }
    }
}
$sum = $depth * $horizontal
$sum