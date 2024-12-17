# Get text from clipboard
$text = Get-Clipboard

# Helper functions to check character types
function Is-ChineseChar([char]$char) {
    return $char -ge 0x4E00 -and $char -le 0x9FA5
}

function Is-EnglishChar([char]$char) {
    return ($char -ge 'A' -and $char -le 'Z') -or ($char -ge 'a' -and $char -le 'z')
}

$result = ""
# Process the text
for ($i = 0; $i -lt $text.Length; $i++) {

    $currentChar = $text[$i]
    # Add space if transitioning between Chinese and English
    if ($i -gt 0 -and (Is-EnglishChar $currentChar) -ne (Is-EnglishChar $text[$i - 1])) {
        $result += " "
    }
    $result += $currentChar

}

# Output the result
$result

# Save result to clipboard
Set-Clipboard -Value $result
