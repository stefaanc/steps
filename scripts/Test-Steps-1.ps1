#
# more info: https://github.com/stefaanc/steps
#
#
# using environment vars
#
#     $env:STEPS_LOG_FILE = "$ROOT\logs\test-steps.log"
#     Test-Steps.ps1
# or
#     $env:STEPS_LOG_FILE = "$ROOT\logs\test-steps.log"
#     $env:STEPS_LOG_APPEND = "true"
#     Test-Steps.ps1
#
#
# using arguments
#
#     Test-Steps.ps1 "$ROOT\logs\test-steps.log"
# or
#     Test-Steps.ps1 "$ROOT\logs\test-steps.log" "true"
#
#
# making $global scope vars available in powershell
#
#     & Test-Steps.ps1 "$ROOT\logs\test-steps.log"
# or
#     & Test-Steps.ps1 "$ROOT\logs\test-steps.log" "true"
#
#
# using packer
#
#     "provisioners": [
#         {
#             "type": "shell-local",
#             "execute_command": ["PowerShell", "-NoProfile", "{{.Vars}}{{.Script}}; exit $LASTEXITCODE"],
#             "env_var_format": "$env:%s=\"%s\"; ",
#             "tempfile_extension": ".ps1",
#             "environment_vars": [
#                 "LOG_FILE={{ user `root` }}/logs/local-test-steps.log",
#                 "LOG_APPEND="
#             ],
#             "scripts": [
#                 "{{ user `root` }}/scripts/local/Test-Steps.ps1"
#             ]
#         }
#
#
# seeing the error status
#
#     Write-Output "`$?=$?" "`$LASTEXITCODE=$LASTEXITCODE" "`$LASTEXITMESSAGE='$LASTEXITMESSAGE'" "`$Error.Count=$( $Error.Count )"
#
#
# clearing errors: set $? to $true; set $LASTEXITCODE to 0; clear $LASTEXITMESSAGE; clear errors
#
#     $null | Out-Null; cmd /c "exit 0"; $global:LASTEXITMESSAGE=''; $Error.clear()
#
#
param (
    $STEPS_LOG_FILE = $env:STEPS_LOG_FILE,       # for '.steps.ps1'
    $STEPS_LOG_APPEND = $env:STEPS_LOG_APPEND,   # for '.steps.ps1'
    $STEPS_COLORS = $env:STEPS_COLORS            # for '.steps.ps1'
)

. "$(Split-Path -Path $script:MyInvocation.MyCommand.Path)\.steps.ps1"
trap { do_trap }

do_script

#
# do something
#
do_step "do something"

Write-Output "do something"

#
# do something else using 'do_echo'
#
do_step "do something else using 'do_echo'"

Write-Output "do something else using 'do_echo'"
for ($i = 1; $i -le 3; $i++) {
    do_echo "use 'do_echo'"
    Start-Sleep 1
}

#
# generate an error using 'exit' (THIS IS NOT CAUGHT)
#
do_step "generate an error using 'exit' (THIS IS NOT CAUGHT)"

Write-Output "generate an error using 'exit' (THIS IS NOT CAUGHT)"
#exit 42

#
# handle a command using 'do_catch_exit'
#
do_step "handle a command using 'do_catch_exit'"

Write-Output "handle a command using 'do_catch_exit'"
#cmd /c "exit 42"; do_catch_exit                                                    # gives: ( "$?" -eq "False" ), ( "$exitcode" -eq "42" ), no error trapped
#cmd /c "exit 42"; $null = $null; do_catch_exit                                     # gives: ( "$?" -eq "True" ),  ( "$exitcode" -eq "42" ), no error trapped
#cmd /c "exit 0"; Get-Variable -Name '$null' -ErrorAction 'Ignore'; do_catch_exit   # gives: ( "$?" -eq "False" ), ( "$exitcode" -eq "0" ), no error trapped

#
# generate an error using 'do_exit'
#
do_step "generate an error using 'do_exit'"

Write-Output "generate an error using 'do_exit'"
#do_exit 42
#echo "xxx"; do_exit 42 | Out-Null
#echo "xxx"; do_exit 42 > _test.log
#echo "xxx"; do_exit 42; echo "yyy"

#
# generate an error using 'throw'
#
do_step "generate an error using 'throw'"

Write-Output "generate an error using 'throw'"
#throw "my error"
#throw 42
echo "xxx"; throw 42; echo "yyy"

#
# run another script
#
do_step "run another script"

Write-Output "run another script"
& "$(Split-Path -Path $script:MyInvocation.MyCommand.Path)\Test-Steps-2.ps1"

#
# do final thing
#
do_step "do final thing"

Write-Output "final thing"

#
# exit
#
do_exit 0
