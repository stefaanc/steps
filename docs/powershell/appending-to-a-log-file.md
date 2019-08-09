## Appending To A Log-file

Let's modify the basic script "Intro-1.ps1", and add an option to append to the log-file.

```powershell
#
# Intro-1.ps1
#

$STEPS_LOG_FILE = ".\intro-1.log"
$STEPS_LOG_APPEND = $true        # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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

- `$STEPS_LOG_APPEND = $true` appends the output to the log-file.

  > :information_source:  
  > A value `$false`, `$null`, or `""` disables appending.  
  > Any other value enables appending.

  > :bulb:  
  > Use a value `$false`, `$null`, or `""` to override `$env:STEPS_LOG_APPEND`

When running the script, the log-file will look something like

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
# ======================================================
# Script: C:\Users\stefaanc\steps\playground\intro-2.ps1
# ======================================================
#


#
# do something
#

doing something

#
# do something else
#

.   please wait...
.   please wait...
.   please wait...

#
# do final thing
#

doing final thing

# ==============================


#
# do final thing
#

doing final thing

# ==============================


#
# ======================================================
# Script: C:\Users\stefaanc\steps\playground\intro-1.ps1
# ======================================================
#
# @ Host: FRM-STEFAANC-L
# >> Log: .\intro-1.log
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

- remark that the first part of the log-file is from our previous test
