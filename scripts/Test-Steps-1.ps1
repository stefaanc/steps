#
# more info: https://github.com/stefaanc/steps
#
param (
    [string]$STEPS_LOG_FILE,     # for '.steps.ps1'
    [string]$STEPS_LOG_APPEND,   # for '.steps.ps1'
    [string]$STEPS_COLORS = $env:STEPS_COLORS,   # for '.steps.ps1'
    [string]$Parameter
)

. "$(Split-Path -Path $script:MyInvocation.MyCommand.Path)\.steps.ps1"
trap { do_trap }

do_cleanup 'do_echo "### cleaning up 1 ###"'

do_script

#
do_step "test parameter"

do_echo "`$Parameter = $Parameter"

#
do_step "do something"

Write-Output "doing something"

#
do_step "do something else using 'do_echo'"

Write-Output "doing something else using 'do_echo'"
for ($i = 1; $i -le 3; $i++) {
    do_echo "waiting"
    Start-Sleep 1
}

#
do_step "generate an error using 'exit' (THIS IS NOT CAUGHT)"

Write-Output "generating an error using 'exit' (THIS IS NOT CAUGHT)"
#exit 42

#
do_step "handle a command using 'do_catch_exit'"

Write-Output "handling a command using 'do_catch_exit'"
#cmd /c "exit 42"; do_catch_exit                                                    # gives: ( "$?" -eq "False" ), ( "$exitcode" -eq "42" ), no error trapped
#cmd /c "exit 42"; $null = $null; do_catch_exit                                     # gives: ( "$?" -eq "True" ),  ( "$exitcode" -eq "42" ), no error trapped
#cmd /c "exit 0"; Get-Variable -Name '$null' -ErrorAction 'Ignore'; do_catch_exit   # gives: ( "$?" -eq "False" ), ( "$exitcode" -eq "0" ), no error trapped

#
do_step "generate an error using 'do_exit'"

Write-Output "generating an error using 'do_exit'"
#do_exit 42
#echo "xxx"; do_exit 42 | Out-Null
#echo "xxx"; do_exit 42 > _test.log
#echo "xxx"; do_exit 42; echo "yyy"

#
do_step "generate an error using 'throw'"

Write-Output "generating an error using 'throw'"
#throw "my error"
#throw 42
#echo "xxx"; throw 42; echo "yyy"

#
do_step "run another script"

Write-Output "running another script"
& "$(Split-Path -Path $script:MyInvocation.MyCommand.Path)\Test-Steps-2.ps1"

#
do_step "do final thing"

Write-Output "doing final thing"

#
do_exit 0
