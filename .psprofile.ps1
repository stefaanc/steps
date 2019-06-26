$ROOT = "$HOME\Projects\steps"

$env:ROOT = "$ROOT"
$env:PATH = "$env:PATH;$ROOT\scripts"

if ( -not (Get-Location).Path.StartsWith("$ROOT") ) {
    Set-Location "$ROOT"
}

Apply-PSConsoleSettings $ROOT\.psconsole.json

$e = [char]27
$env:STEPS_COLORS = "$e[38;5;45m,$e[92m,$e[93m,$e[91m,$e[0m"
#                    normal     ,green ,yellow,red   ,reset
