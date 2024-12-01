# https://adventofcode.com/2024/day/1 
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
# Read the file and process each line with switch. Faster than get-content shenanigans
switch -Regex -File $inputfile  {
    '^\s*(?<left>\d+)\s+(?<right>\d+)\s*$' {
        $left.Add([int]$matches['left'])
        $right.Add([int]$matches['right'])
        ++$count
    }
    Default {}
}


$right.Sort()
$left.Sort()
$sum = 0
for ($i = 0; $i -lt $length; $i++) {
   $sum += [Math]::Abs($right[$i] - $left[$i])
}
$sum