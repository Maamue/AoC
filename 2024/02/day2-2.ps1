$starttime = Get-Date
$safereports = 0
$almostsafereports = 0

# Switch between inputs
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

        if (($ascending -and ($numbers[$i] -lt $numbers[$i - 1])) -or
            (-not $ascending -and ($numbers[$i] -gt $numbers[$i - 1]))) {
            return 0 # Unordered
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

    for ($i = 1; $i -lt $numbers.Count; $i++) {
        # If any difference is greater than 3, the report is not safe
        $abs = [Math]::Abs($numbers[$i] - $numbers[$i - 1])
        if ($abs -gt 3 -or $abs -eq 0) {
            return $false
        }
    }

    return $true # Conditions met to be safe
}

function Test-ForSafetyWithReduction {
    param (
        [int[]]$numbers
    )

    for ($i = 0; $i -lt $numbers.Count; $i++) {
        # Copy without element [$i] to check. condition to account for first and last element
        $modifiedNumbers = if ($i -eq 0) {
            $numbers[($i + 1)..($numbers.Count - 1)]
        }
        elseif ($i -eq ($numbers.Count - 1)) {
            $numbers[0..($i - 1)]
        }
        else {
            $numbers[0..($i - 1)] + $numbers[($i + 1)..($numbers.Count - 1)]
        }
        
        # Recheck with modified set
        $result = Get-Order -numbers $modifiedNumbers
        if ($result -ne 0 -and (Get-LevelDifference -numbers $modifiedNumbers)) {
            return $true
        }
    }

    return $false
}

$collection = Get-Content -Path $inputfile -ReadCount 0

$collection | ForEach-Object {
    $line = $_
    $numbers = $line -split ' ' | ForEach-Object { [int]$_ }
    $result = Get-Order -numbers $numbers

    switch ($result) {
        1 { 
            # Write-Host "Ascending: $line"
            if ((Get-LevelDifference -numbers $numbers)) {
                # Write-Host "Report $line is safe. Adding to total"
                ++$safereports
            } 
            elseif ((Test-ForSafetyWithReduction -numbers $numbers)) {
                # Write-Host "Report $line can be made safe by removing one number. Adding to almost safe total"
                ++$almostsafereports
            }
            else {
                # Write-Host "Report $line can not be made safe"
            }
        }
        -1 {
            # Write-Host "Descending: $line" 
            if ((Get-LevelDifference -numbers $numbers)) {
                # Write-Host "Report $line is safe. Adding to total"
                ++$safereports
            } 
            elseif ((Test-ForSafetyWithReduction -numbers $numbers)) {
                # Write-Host "Report $line can be made safe by removing one number. Adding to almost safe total"
                ++$almostsafereports
            }
            else {
                # Write-Host "Report $line can not be made safe"
            }
        }
        0 { 
            # Write-Host "Unordered: $line"
            if ((Test-ForSafetyWithReduction -numbers $numbers)) {
                # Write-Host "Report $line can be made safe by removing one number. Adding to almost safe total"
                ++$almostsafereports
            }
            else {
                # Write-Host "Report $line can not be made safe"
            }
        }
        Default {
            # Write-Host "Report $line can not be made safe"
        }
    }
}

$endtime = Get-Date
if ($(($endtime - $starttime).TotalSeconds) -lt 1) {
    Write-Host "Duration: $(($endtime-$starttime).TotalMilliseconds) milliseconds"
}
else {
    Write-Host "Duration: $(($endtime-$starttime).TotalSeconds) Seconds"
}
Write-Host "Safe Reports: $safereports"
Write-Host "Almost Safe Reports: $almostsafereports"
Write-Host "Sum: $($safereports + $almostsafereports)"