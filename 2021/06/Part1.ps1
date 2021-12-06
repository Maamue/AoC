$school = [System.Collections.Generic.List[int]]::new()
(Get-Content $PWD\input.txt -Raw) -split ',' | ForEach-Object { $school.Add($_) }

$generations = 80
$newFish = 0
$maxAge = 8

$fishByAge = @{}
for ($i = 0; $i -le $maxAge; $i++) {
    $fishByAge[$i] = ($school | Where-Object { $_ -eq $i }).Count
}

while ($generations -gt 0) {
    Write-Verbose -Message "run: $generations"
    # failed to create these dynamically..
    $newFish = $fishByAge[0]
    $fishByAge[0] = $fishByAge[1]
    $fishByAge[1] = $fishByAge[2]
    $fishByAge[2] = $fishByAge[3]
    $fishByAge[3] = $fishByAge[4]
    $fishByAge[4] = $fishByAge[5]
    $fishByAge[5] = $fishByAge[6]
    $fishByAge[6] = $fishByAge[7] + $newFish
    $fishByAge[7] = $fishByAge[8]
    $fishByAge[8] = $newFish
    
    $generations--
}    


[int64]$total = 0
for ($i = 0; $i -le $maxAge; $i++) {
    Write-Verbose -Message 'final loop'
    $total += $fishByAge[$i] 
}
$total