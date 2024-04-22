Install-Module -Name PowerShellHumanizer

Function Convert-NumWord2NumInt($wordnum) {
    $htSingleDigits = @{'zero' = 0; 'one' = 1; 'two' = 2; 'three' = 3; 'four' = 4; 'five' = 5; 'six' = 6; 'seven' = 7; 'eight' = 8; 'nine' = 9 }
    $htUniques = @{'ten' = 10; 'eleven' = 11; 'twelve' = 12; 'thirteen' = 13 }
    if ($htSingleDigits.Contains($wordnum)) {
        return $htSingleDigits[$wordnum]
    }
    elseif ($htUniques.Contains($wordnum)) {
        return $htUniques[$wordnum]
    }
}

$path = "C:\Users\Zack\Documents\Advent of Code\AOCd1.txt"
$Input = Get-Content $path
$Output = @()
$WordNumbers = @("one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "zero")

for ($inputCounter = 0; $inputCounter -lt $input.Count; $inputCounter++) {
    $parsed = $input[$inputCounter]
    $intergers = @()
    $chars = ""
    for ($charCounter = 0; $charCounter -lt $parsed.Length; $charCounter++) {
        #write-host $parsed[$charCounter]
        $returnedInterger = 0
        $charParsed = $parsed[$charCounter]
        if ([int]::TryParse($charParsed, [ref]$returnedInterger)) {
            $intergers += [PSCustomObject]@{
                intergerorder = $charCounter
                interger      = $returnedInterger
            }
        }
    }
    $WordNumbers | % { if ($parsed.Contains($_)) {
            $parsedWordLenCounter = 0
            $startofnum = 0
            while ($parsedWordLenCounter -lt $parsed.Length) {
                if (($parsed.IndexOf($_, $parsedWordLenCounter)) -ne -1) {
                    $startofnum = $parsed.IndexOf($_,$parsedWordLenCounter)
                    $wordoutput = [string]::concat($parsed[$startofnum..($startofnum + ($_.Length - 1))])
                    $intergers += [PSCustomObject]@{
                        intergerorder = $startofnum
                        interger      = (Convert-NumWord2NumInt $wordoutput)
                    }
                    $parsedWordLenCounter = ($_.length+$startofnum)
                    
                    
                } else {break}
                

            }#<--- End of While
    
        }#<--- End of If
    } #<--- End of Foreach-Object
    
    $intergers = $intergers | Sort-Object -Property intergerorder
    $intergers
    $processStringtoInt = "$($intergers[0].interger)$($intergers[$intergers.Length-1].interger)"
    $ArrayOutput += [int]$processStringtoInt
}

write-host $ArrayOutput
Clear-Variable  ArrayOutput, chars, processStringtoInt, input, intergers





