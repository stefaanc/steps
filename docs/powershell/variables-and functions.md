## Variables And Functions

### Variables To Control STEPS

- `$STEPS_COLORS` (or `$env:STEPS_COLORS`): see [Changing colors](./changing-colors.md)

- `$STEPS_LOG_FILE` (or `$env:STEPS_LOG_FILE`): see [Summarizing to terminal and logging to file](./summarizing-to-terminal-and-logging-to-file.md)

- `$STEPS_LOG_APPEND` (or `$env:STEPS_LOG_APPEND`): see [Appending to a log-file](./appending-to-a-log-file.md)

- `$STEPS_PARAMS`: the parameters to use when calling the root-script a second time in order to set up the redirections.  Steps sets this to `@( Get-PSCallStack )[1].InvocationInfo.BoundParameters`, but it has to be set by the root-script when it uses traditional positional parameters (as opposed to a `param()` statement) - see [Scripts with parameters](./scripts-with-parameters.md)

### Automatic Variables

- `$STEPS_SCRIPT`: string with the full path and name of the root-script

- `$STEPS_PARAMS`: the parameters used or to use when calling the root-script a second time in order to set up the redirections.  Steps sets this to `@( Get-PSCallStack )[1].InvocationInfo.BoundParameters`, but it has to be set by the root-script when it uses traditional positional parameters (as opposed to a `param()` statement) - see [Scripts with parameters](./scripts-with-parameters.md)

- `$STEPS_STAGE`: is `"init"` when executing the root-script for the first time, `"root"` when executing the root-script for the second time (in order to set up the redirections), or `"branch"` when executing a script called by the root-script

- `$STEPS_INDENT`: string to use as prefix for `do_echo`.  This starts with `".   "` in the root-script, and another `".   "` is added with each nested branch-script

- `$STEPS_PREVIOUS_INDENT`: string that is used as prefix for `do_echo` in the parent-script.  See `$STEPS_INDENT`

- `$STEPS_CLEANUP`: string with command that has to be executed before exiting the script

- `$global:LASTSTEP`: starts with `0`, incremented with each `do_step`

- `$LASTEXITCODE`: PowerShell's automatic variable, set when exiting a script

- `$global:LASTIGNOREDEXITCODE`: the last non-zero exit-code that was ignored when using the `-IgnoreExitCodes` option for `do_catch_exit`

- `$global:LASTEXITSCRIPT`: the "script" value in the last STEPS `ERROR`-message

- `$global:LASTEXITLINENO`: the "line" value in the last STEPS `ERROR`-message

- `$global:LASTEXITCHARNO`: the "char" value in the last STEPS `ERROR`-message

- `$global:LASTEXITCOMMAND`: the "cmd" value in the last STEPS `ERROR`-message

- `$global:LASTEXITMESSAGE`: the error-message in the last STEPS `ERROR`-message

- `$global:LASTEXITTRAPPED`: `$true` if an error was already reported in a nested script

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
  - resets the `$?`, `$LASTEXITCODE`, `$global:LASTEXIT*` and `$Error` variables

- `do_exit $exitcode ["$message"]`
  - [Exiting](./exiting.md)

- `do_catch_exit [-IgnoreExitStatus] [-IgnoreExitCode] [-IgnoreExitCodes]`
  - [Catching exits](./catching-exits.md)
  - [Native commands that write status-info to stderr](./native-commands-that-write-status-info-to-stderr.md)  
  - [Native commands that use exitcode for status-info](./native-commands-that-use-exitcode-for-status-info.md)  

- `do_continue`
  - [Native commands that write status-info to stderr](./native-commands-that-write-status-info-to-stderr.md)

- `do_trap`
  - [A successful script](./a-successful-script.md)
  - [Summarizing to terminal and logging to file](./summarizing-to-terminal-and-logging-to-file.md)
