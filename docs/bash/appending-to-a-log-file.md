## Appending To A Log-file

Let's modify the basic script "intro-3.bash", and add an option to append to the log-file.

```shell
#
# intro-3.bash
#

STEPS_LOG_FILE="./intro-3.log"
STEPS_LOG_APPEND="true"   # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

. ./.steps.bash

do_script

#
do_step "do something"

echo "doing something"

#
do_step "do something else"

echo "doing something else"

#
do_step "do final thing"

echo "doing final thing"

#
do_exit 0
```

- `STEPS_LOG_APPEND="true"` appends the output to the log-file.

  > :information_source:  
  > A value `""` for `"$STEPS_LOG_APPEND"` disables appending.  
  > Any other value enables appending.

When running the script, the log-file will look something like

```text

#
# ======================
# Script: ./intro-3.bash
# ======================
#
# @ Host: gateway-hyv.stefaanc.kluster.local
# > Log:  ./intro-3.log
#


#
# do something
#

doing something

#
# do something else
#


#
# ======================
# Script: ./intro-4.bash
# ======================
#


#
# do something
#

doing something

#
# do something else
#

# please wait...
# please wait...
# please wait...

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
# ======================
# Script: ./intro-3.bash
# ======================
#
# @ Host: gateway-hyv.stefaanc.kluster.local
# >> Log: ./intro-3.log
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

- remark that the first part of the log-file is from a previous test
