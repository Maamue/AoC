using namespace System.Collections.Generic

# switch between inputs
$test = $false
if ($test) {
    $inputfile = $PSScriptRoot + '\exampleinput.txt'
} else {
    $inputfile = $PSScriptRoot + '\input.txt'
}

$left = [List[int]]::new()
$right = [List[int]]::new()
$count = 0
$sum = 0

# Read the file and process each line with switch. Faster than get-content shenanigans
switch -Regex -File $inputfile  {
    '^\s*(?<left>\d+)\s+(?<right>\d+)\s*$' {
        $left.Add([int]$matches['left'])
        $right.Add([int]$matches['right'])
        ++$count
    }
    Default {}
}

# count every number in the right list
$rightCounts = @{}
foreach ($rightNumber in $right) {
    if ($rightCounts.ContainsKey($rightNumber)) {
        $rightCounts[$rightNumber]++
    } else {
        $rightCounts[$rightNumber] = 1
    }
}

# compare the left list with the right list and directly sum up the distance
$leftInRightCounts = @{}
foreach ($leftNumber in $left) {
    if ($rightCounts.ContainsKey($leftNumber)) {
        $leftInRightCounts[$leftNumber] = $rightCounts[$leftNumber]
        $sum += $rightCounts[$leftNumber] * $leftNumber
    } else {
        $leftInRightCounts[$leftNumber] = 0
    }
}

# $leftInRightCounts
$sum