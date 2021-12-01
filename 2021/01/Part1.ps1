$sonar = (Get-Content $PSScriptRoot\input.txt) -as [int[]]

$DepthIncrease = 0
for ($i = 0; $i -lt $sonar.Count - 1; $i++) {
    if ($sonar[$i+1] -gt $sonar[$i]) {
        $DepthIncrease++
    }
}
$DepthIncrease
