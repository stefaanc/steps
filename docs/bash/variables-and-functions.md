## Variables And Functions

### Variables To Control STEPS

- `$STEPS_COLORS` (or `$env:STEPS_COLORS`): see [Changing colors](./changing-colors.md)

- `$STEPS_LOG_FILE` (or `$env:STEPS_LOG_FILE`): see [Summarizing to terminal and logging to file](./summarizing-to-terminal-and-logging-to-file.md)

- `$STEPS_LOG_APPEND` (or `$env:STEPS_LOG_APPEND`): see [Appending to a log-file](./appending-to-a-log-file.md)

### Automatic Variables

- `$STEPS_SCRIPT`: string with the full path and name of the root-script

- `$STEPS_STAGE`: is `"root"` when executing the root-script, or `"branch"` when executing a script called by the root-script

- `$STEPS_INDENT`: string to use as prefix for `do_echo`.  This starts with `".   "` in the root-script, and another `".   "` is added with each nested branch-script

- `$STEPS_PREVIOUS_INDENT`: string that is used as prefix for `do_echo` in the parent-script.  See `$STEPS_INDENT`

- `$STEPS_CLEANUP`: string with command that has to be executed before exiting the script

- `global $LASTSTEP`: starts with `0`, incremented with each `do_step`.  This variable is propagated to the calling scope using the GLOBALS lib.

- `global $LASTEXITCODE`: PowerShell's automatic variable, set when exiting a script.  This variable is propagated to the calling scope using the GLOBALS lib.

- `global $LASTEXITSCRIPT`: the "script" value in the last STEPS `ERROR`-message.  This variable is propagated to the calling scope using the GLOBALS lib.

- `global $LASTEXITCOMMAND`: the "cmd" value in the last STEPS `ERROR`-message.  This variable is propagated to the calling scope using the GLOBALS lib.

- `global $LASTEXITLINENO`: the "line" value in the last STEPS `ERROR`-message.  This variable is propagated to the calling scope using the GLOBALS lib.

- `global $LASTEXITMESSAGE`: the error-message in the last STEPS `ERROR`-message.  This variable is propagated to the calling scope using the GLOBALS lib.

- `global $LASTEXITTRAPPED`: `$true` if an error was already reported in a nested script.  This variable is propagated to the calling scope using the GLOBALS lib.

### Functions

- `do_script`:
  - [A successful script](./a-successful-script.md)
  - [Summarizing to terminal and logging to file](./summarizing-to-terminal-and-logging-to-file.md)

- `do_step "$description"`
  - [A successful script](./a-successful-script.md)
  - [Summarizing to terminal and logging to file](./summarizing-to-terminal-and-logging-to-file.md)

- `do_echo [(-Color | -ForegroundColor | -c) "$color"] [-BackgroundColor "$color"] "$message"`
  - [Providing more information](./providing-more-information.md)
  - [Changing colors](./changing-colors.md)

- `do_reset`: 
  - resets the `$?` and `$LASTEXIT*` variables

- `do_cleanup`:
  - [Cleaning-up](./cleaning-up.md)

- `do_exit $exitcode ["$message"]`
  - [Exiting](./exiting.md)

- `do_trap`
  - [A successful script](./a-successful-script.md)
  - [Summarizing to terminal and logging to file](./summarizing-to-terminal-and-logging-to-file.md)
