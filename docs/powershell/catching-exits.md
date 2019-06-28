## Catching Exits

Let's modify the basic script to simulate a command that doesn't throw errors but instead exits with an exitcode, and then catch that exitcode.

```powershell
#
# Intro-1.ps1
#
$STEPS_LOG_FILE = ".\intro-1.log"

. ./.steps.ps1
trap { do_trap }

do_script

#
do_step "do something"

Write-Output "doing something"

#
do_step "do something else"

cmd /c "exit 42"; do_catch_exit  # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#
do_step "do final thing"

Write-Output "doing final thing"

#
do_exit 0
```

- `do_catch_exit` verifies `$?` and `$LASTEXITCODE`, and throws an error if necessary

When running the script, our terminal will now look something like

![intro-1.catch.png](./screenshots/intro-1.catch.png)

And the log-file will look something like

```text

#
# ======================================================
# Script: C:\Users\stefaanc\steps\playground\intro-1.ps1
# ======================================================
#
# @ Host: FRM-STEFAANC-L
# > Log:  .\intro-1.log
#


#
# do something
#

doing something

#
# do something else
#


#
# ERROR: 42, line: 19, char: 19, cmd: 'do_catch_exit' > "caught exitcode 42"
#
```
