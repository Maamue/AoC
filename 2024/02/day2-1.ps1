$starttime = Get-Date
$safereports = 0
# switch between inputs
$test = $false
if ($test) {
    $inputfile = '.\exampleinput.txt'
}
else {
    $inputfile = '.\input.txt'
}

function Get-Order {
    param (
        [int[]]$numbers
    )

    if ($numbers.Count -eq 1) {
        return 0  # Only one number, no order
    }

    $ascending = $numbers[1] -gt $numbers[0]

    for ($i = 1; $i -lt $numbers.Count; $i++) {
        if ($numbers[$i] -eq $numbers[$i - 1]) {
            continue # Skip if consecutive numbers are the same
        }

        # return 0 (unordered)
        if (($ascending -and ($numbers[$i] -lt $numbers[$i - 1])) -or
            (-not $ascending -and ($numbers[$i] -gt $numbers[$i - 1]))) {
            return 0
        }
    }

    if ($ascending) {
        return 1  # Ascending
    }
    else {
        return -1  # Descending
    }
}

function Get-LevelDifference {
    param (
        [int[]]$numbers
    )

    # Loop through the numbers, checking adjacent differences
    for ($i = 1; $i -lt $numbers.Count; $i++) {
        # If any difference is greater than 3, the report is not safe
        if ([Math]::Abs($numbers[$i] - $numbers[$i - 1]) -gt 3) {
            return $false
        }
    }

    # If the loop completes and all differences are within 3, the report is safe
    return $true
}


$collection = Get-Content -Path $inputfile -ReadCount 0

$collection | ForEach-Object {
    $line = $_
    $numbers = $line -split ' ' | ForEach-Object { [int]$_ }
    $result = Get-Order -numbers $numbers

    switch ($result) {
        1 { 
            Write-Output "Ascending: $line"
            if (-not (Get-LevelDifference -numbers $numbers)) {
                Write-Host "Report $line is safe. Adding to total"
                ++$safereports
            } 
        }
        -1 {
            Write-Output "Descending: $line" 
            if (-not (Get-LevelDifference -numbers $numbers)) {
                Write-Host "Report $line is safe. Adding to total"
                ++$safereports
            } 
        }
        0 { Write-Output "Unordered: $line" }
    }
}

$endtime = Get-Date
if ($(($endtime - $starttime).TotalSeconds) -lt 1) {
    Write-Host "Duration: $(($endtime-$starttime).TotalMilliseconds) milliseconds"
}
else {
    Write-Host "Duration: $(($endtime-$starttime).TotalSeconds) Seconds"
}
$safereports


# $collection | Foreach-Object -ThrottleLimit 32 -Parallel {
#   Write-Host "$_ in Thread $([System.Threading.Thread]::CurrentThread.ManagedThreadId)" 
# }

# 1..20 | ForEach-Object -parallel { 
#     Write-host "Objekt #$_ in Thread $([System.Threading.Thread]::CurrentThread.ManagedThreadId)" 
#     sleep -Seconds 2 } -ThrottleLimit 5 

