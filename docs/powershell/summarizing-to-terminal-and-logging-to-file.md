## Summarizing To Terminal And Logging To File

Let's define a log-file in our basic script

```powershell
#
# Intro-1.ps1
#
$STEPS_LOG_FILE = ".\intro-1.log"   # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

. ./.steps.ps1
trap { do_trap }

do_script

#
do_step "do something"

Write-Output "doing something"

#
do_step "do something else"

Write-Output "doing something else"

#
do_step "do final thing"

Write-Output "doing final thing"

#
do_exit 0
```

- `$STEPS_LOG_FILE` is setting the log-file STEPS will use
- The output from `do_script`, `do_step` and `do_exit` will now be sent to both the terminal and the log-file, while all other output will be sent to the log-file only.

  > :bulb:  
  > you can also use an environment `$env:STEPS_LOG_FILE` to set the log-file
  > or perhaps you prefer a parameter in your script `param( $STEPS_LOG_FILE = $env:STEPS_LOG_FILE )`

When running the script, our terminal will now look something like

![intro-1.successful.png](./screenshots/intro-1.successful.png)

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

doing something else

#
# do final thing
#

doing final thing

# ==============================
```
