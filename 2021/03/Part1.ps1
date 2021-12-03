$sonar = Get-Content -Path "$PSScriptRoot\input.txt"

$TotalLength = $sonar.Count
$BitLength = $sonar[0].Length
$ones, $position, $dominant = 0, 0, 0

[string]$gamma = ''
[string]$epsilon = ''

# setup gamma
while ($position -lt $BitLength) {
    $ones = 0
    foreach ($bits in $sonar) {
        $bit = $bits.ToCharArray()
        if ($bit[$position] -eq '1') {
            $ones++
        }
    }
    if ($ones -ge $TotalLength / 2) {
        $dominant = 1
    } else {
        $dominant = 0
    }
    $gamma += $dominant
    $position++
}

# setup epsilon
$epsilonCounter = $gamma.ToCharArray()
foreach ($bit in $epsilonCounter) {
    switch ($bit) {
        '1' { $epsilon += 0 }
        '0' { $epsilon += 1 }
    }
}

# result
$gammarate = [Convert]::ToInt32($gamma, 2)
$epsilonrate = [Convert]::ToInt32($epsilon, 2)

$result = $gammarate * $epsilonrate
$result