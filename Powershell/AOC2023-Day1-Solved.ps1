$path = #Insert FilePath
$Input = Get-Content $path
$Output = @()

for($inputCounter = 0; $inputCounter -lt $input.Count; $inputCounter++){
$parsed = $input[$inputCounter]
$intergers = @()
    for($charCounter = 0;$charCounter -lt $parsed.Length; $charCounter++){
    #write-host $parsed[$charCounter]
    $returnedInterger=0
        $charParsed = $parsed[$charCounter]
        if([int]::TryParse($charParsed,[ref]$returnedInterger)){
        $intergers += $returnedInterger
        }
    }
    $processStringtoInt = "$($intergers[0])$($intergers[$intergers.Length-1])"
    $ArrayOutput += [int]$processStringtoInt
}

write-host $ArrayOutput
Clear-Variable  ArrayOutput