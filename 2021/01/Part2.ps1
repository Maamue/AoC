$sonar = (Get-Content $PSScriptRoot\input.txt) -as [int[]]
$DepthIncrease, $previous = 0

for ($i = 0; $i -lt $sonar.Count; $i++) {
    $current = $sonar[$i] + $sonar[$i + 1] + $sonar[$i + 2]
   
    if (
        [String]::IsNullOrWhiteSpace($sonar[$i + 2]) -or 
        $i -eq 0
    ) { continue }

    if ($current -gt $previous) {
        $DepthIncrease++
    }
    $previous = $current
}
$DepthIncrease
