# PowerShell function example script: Modify any SSN with a replacement
# Author: cavonac
Function Update-Ssn {
    [cmdletbinding()]
    Param (
        [string]$InputFile, 
        [string]$OutputFile, 
        [string]$ReplaceWith, 
        [string]$regex="\d\d\d-\d\d-\d\d\d\d")
    Process {
        if (Test-Path -Path $InputFile) {
            Write-Debug "$InputFile File exists. Starting replace..."
            foreach($line in Get-Content $InputFile)
            {
                $new = ""
                foreach($word in $line.Split(" "))
                {                    
                    if ($word -match $regex)
                    {
                        Write-Debug "$word Matched! Masking..."
                        $new += $ReplaceWith
                    }
                    else {
                        $new += $word
                    }
                    # add a space after our word
                    $new += " "
                }
                Add-Content -Path $OutputFile -Value $new
            }
        }
        else {
            Write-Output "$InputFile does not exist!"
        }
    }
}

Update-Ssn ssn.txt parsed.txt XXX-XX-XXXX