$sonar = Get-Content -Path $PSScriptRoot\input.txt

$depth, $horizontal, $aim = 0
foreach ($change in $sonar) {
    switch -Regex ($change) {
        '^f' { 
            $movement = [int]($change -replace '[^0-9]', '')
            $horizontal += $movement 
            $depth += $aim * $movement
        }
        '^d' { $aim += [int]($change -replace '[^0-9]', '') }
        '^u' { $aim -= [int]($change -replace '[^0-9]', '') }
    }
}
$sum = $depth * $horizontal
$sum