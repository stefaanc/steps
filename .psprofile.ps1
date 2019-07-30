Set-Variable HOME "$env:USERPROFILE" -Scope Global -Force
( Get-PSProvider 'FileSystem' ).Home = $HOME   # replace "~"

$global:ROOT = "$HOME\Projects\steps"
$env:PATH = "$ROOT\scripts;$env:PATH"

if ( -not ( Get-Location ).Path.StartsWith("$ROOT") ) {
    Set-Location "$ROOT"
}

Apply-PSConsoleSettings "STEPS"

$e = [char]27
$env:STEPS_COLORS = "$e[33m,$e[96m,$e[92m,$e[93m,$e[91m,$e[0m"
#                    normal,bright,green ,yellow,red   ,reset
