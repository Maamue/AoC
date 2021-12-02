$sonar = Get-Content -Path $PSScriptRoot\input.txt

$depth, $horizontal, $sum = 0
foreach ($change in $sonar) {
    switch -Regex ($change) {
        '^f' { 
            $horizontal += [int]($change -replace '[^0-9]', '') 
            break
        }
        '^d' {
            $depth += [int]($change -replace '[^0-9]', '') 
            break
        }
        '^u' { 
            $depth -= [int]($change -replace '[^0-9]', '') 
            break
        }
    }
}
$sum = $depth * $horizontal
$sum