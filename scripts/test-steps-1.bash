#!/bin/bash
#
# more info: https://github.com/stefaanc/steps
#
if (( $# > 0 )) ; then STEPS_LOG_FILE="$1" ; fi     # used in './.steps.sh'
if (( $# > 1 )) ; then STEPS_LOG_APPEND="$2" ; fi   # used in './.steps.sh'
if (( $# > 2 )) ; then STEPS_COLORS="$3" ; fi       # used in './.steps.sh'

. "$( dirname ${BASH_SOURCE[0]} )/.steps.bash"

do_cleanup 'do_echo "### cleaning up 1 ###"'

do_script

#
do_step "do something"

echo "doing something"

#
do_step "do something else using 'do_echo'"

echo "doing something else using 'do_echo'"
for i in `seq 1 3`; do
    do_echo "waiting"
    sleep 1
done

#
do_step "generate an error using 'exit'"

echo "generating an error using 'exit'"
#exit 42
#do_exit 42
#echo "xxx"; do_exit 42 | xargs printf "%s\n"
#echo "xxx"; do_exit 42 > _test.log
#echo "xxx"; do_exit 42; echo "yyy"

#
do_step "handle a command returning an 'error'"

echo "handling a command returning an 'error'"
#x=$y
#unknown-command

#
do_step "run another script"

echo "running another script"
#call "$( dirname ${BASH_SOURCE[0]} )/test-steps-2.bash-xxx"
call "$( dirname ${BASH_SOURCE[0]} )/test-steps-2.bash"

#
do_step "do final thing"

echo "doing final thing"

#
do_exit 0
