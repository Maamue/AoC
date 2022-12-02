$games = (Get-Content -Path $PWD/input.txt) -as [string[]] 
enum Points {
    Lose = 0    # X
    Draw = 3    # Y
    Win = 6     # Z
}
enum Hand {
    Rock = 1        # X
    Paper = 2       # Y
    Scissors = 3    # Z
}
[int]$score, $result, $play = 0, 0, 0
foreach ($play in $games) {
    # necessary because we need both values for the inner if in the switch. otherwise we could loop with switch only
    $result = $play -split ' '
    switch (($result)[0]) {
        # Rock
        'A' { 
            if ($result[1] -eq 'Z') { $score += [int][Points]::Win + ([Hand]::Paper).value__ }
            if ($result[1] -eq 'X') { $score += [int][Points]::Lose + ([Hand]::Scissors).value__  }
            if ($result[1] -eq 'Y') { $score += [int][Points]::Draw + ([Hand]::Rock).value__  }
            
        }
        # Paper
        'B' { 
            if ($result[1] -eq 'Z') { $score += [int][Points]::Win + ([Hand]::Scissors).value__ }
            if ($result[1] -eq 'X') { $score += [int][Points]::Lose + ([Hand]::Rock).value__  }
            if ($result[1] -eq 'Y') { $score += [int][Points]::Draw + ([Hand]::Paper).value__  }
        }
        # Scissors
        'C' { 
            if ($result[1] -eq 'Z') { $score += [int][Points]::Win + ([Hand]::Rock) }
            if ($result[1] -eq 'X') { $score += [int][Points]::Lose + ([Hand]::Paper).value__  }
            if ($result[1] -eq 'Y') { $score += [int][Points]::Draw + ([Hand]::Scissors).value__  }
        }
        Default {
            Write-Debug "Soething is wrong with out input"
        }
    }
}
'The total score is {0}' -f $score
