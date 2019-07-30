#!/bin/bash
#
# more info: https://github.com/stefaanc/steps
#

. "$( dirname ${BASH_SOURCE[0]} )/.steps.bash"

do_script

#
# do something
do_step "do something"

echo "doing something"

#
# do something else using 'do_echo'
do_step "do something else using 'do_echo'"

echo "doing something else using 'do_echo'"
for i in `seq 1 3`; do
    echo -e "waiting" | do_echo
    sleep 1
done

#
# generate an error using 'exit'
do_step "generate an error using 'exit'"

echo "generating an error using 'exit'"
#exit 42
#do_exit 42
#echo "xxx"; do_exit 42 | xargs printf "%s\n"
#echo "xxx"; do_exit 42 > _test.log
#echo "xxx"; do_exit 42; echo "yyy"

#
# handle a command returning an 'error'
do_step "handle a command returning an 'error'"

echo "handling a command returning an 'error'"
#x=$y
#unknown-command

#
# do final thing
do_step "do final thing"

echo "doing final thing"

#
# exit
do_exit 0
