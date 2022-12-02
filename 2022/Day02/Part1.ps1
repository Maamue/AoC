$games = (Get-Content -Path $PWD/input.txt) -as [string[]] 
enum Points {
    Lose = 0
    Draw = 3
    Win = 6
}
enum Hand {
    Rock = 1        # X
    Paper = 2       # Y
    Scissors = 3    # Z
}
[int]$score, $result, $play = 0,0,0
foreach ($play in $games) {
    # necessary because we need both values for the inner if in the switch. Otherwise we could loop with switch only
    $result = $play -split ' '
    switch (($result)[1]) {
        'X' { 
            $score += [Hand]::Rock    
            if ($result[0] -eq 'A') { $score += [Points]::Draw }
            if ($result[0] -eq 'C') { $score += [Points]::Win }
        }
        'Y' { 
            $score += [Hand]::Paper
            if ($result[0] -eq 'B') { $score += [Points]::Draw }
            if ($result[0] -eq 'A') { $score += [Points]::Win }
        }
        'Z' { 
            $score += [Hand]::Scissors
            if ($result[0] -eq 'C') { $score += [Points]::Draw }
            if ($result[0] -eq 'B') { $score += [Points]::Win }
        }
        Default {
            Write-Debug "Soething is wrong with out input"

        }
    }
}
'The total score is {0}' -f $score
