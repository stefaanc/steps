Set-Variable HOME "$env:USERPROFILE" -Scope Global -Force
( Get-PSProvider 'FileSystem' ).Home = $HOME   # replace "~"

$ROOT = "$HOME\Projects\steps"
$PATH = "$ROOT\scripts;$env:PATH"

$env:HOME = $HOME
$env:ROOT = $ROOT
$env:PATH = $PATH

if ( -not ( Get-Location ).Path.StartsWith("$ROOT") ) {
    Set-Location "$ROOT"
}

. Apply-PSConsoleSettings "STEPS"

$e = [char]27
$env:STEPS_COLORS = "$e[38;5;45m,$e[92m,$e[93m,$e[91m,$e[0m"
#                    normal     ,green ,yellow,red   ,reset
