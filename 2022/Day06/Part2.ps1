$datastream = [System.IO.File]::ReadAllText("$PSScriptRoot\input.txt")

Function Get-MessageMarker {
    param (
        [int]
        $DisinctCharacters
    )

    for ($i = 0; $i -le $datastream.Length - $DisinctCharacters; $i++) {
        $identifier = [System.Collections.Generic.HashSet[char]]$datastream[$i..($i + $DisinctCharacters -1)]
        if ($identifier.Count -eq $DisinctCharacters) { 
            $i + $DisinctCharacters 
            break
        }
    }
}

Get-MessageMarker -DisinctCharacters 14
