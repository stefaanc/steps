### Playing With Scopes - a failed call

An example of a failing scenario to understand the flow through the various scopes work, leaving out all code that is not relevant

```
Powershell.exe
______________________________________________________start scope powershell___
| 
|  ...
|
|  # avoid results are showing old stuff
|  PS > cmd /c "exit 0"   # clear $LASTEXITCODE
|  PS > $Error.clear()    # clear $Error
|
|  # ( $? -eq $true )
|  # ( $LASTEXITCODE -eq 0 )
|  # ( $Error.Count -eq 0 )
|
|  PS > & Example-Steps.ps1
|  ____________________________________________start scope 1st Example-Steps___
|  |
|  |  . .steps.ps1
|  |  ......................................................start 1st .steps...
|  |  $STEPS_STAGE = "init"
|  |
|  |  $ErrorActionPreference='Stop'
|  |  $InformationPreference='Continue'
|  |
|  |  function do_exec { ... }   # called from 1st 'do_script'
|  |  function do_script { ... }
|  |  function do_step { ... }
|  |  function do_echo { ... }
|  |  function do_exit { ... }
|  |  function do_reset_exitcode { ... }
|  |  function do_catch_exit { ... }
|  |  function do_check_exit { ... }
|  |  function do_trap { ... }
|  |  ........................................................end 1st .steps...
|  |  trap { do_trap }
|  |  
|  |  do_script
|  |  ___________________________________________________start 1st do_script___
|  |  |  ______________________________________________________start do_exec___
|  |  |  |
|  |  |  |  try {
|  |  |  |
|  |  |  |      & "Example-Steps.ps1" "$STEPS_LOG_FILE" 5>&1 4>&1 3>&1 2>&1 > "$STEPS_LOG_FILE"
|  |  |  |      _______________________________start scope 2nd Example-Steps___
|  |  |  |      |
|  |  |  |      |  . .steps.ps1
|  |  |  |      |  .........................................start 2nd .steps...
|  |  |  |      |  $STEPS_STAGE = "root"
|  |  |  |      |  return
|  |  |  |      |  ...........................................end 2nd .steps...
|  |  |  |      |  trap { do_trap }
|  |  |  |      |  
|  |  |  |      |  do_script
|  |  |  |      |
|  |  |  |      |  do_step "run another script"
|  |  |  |      |  & "Example-Steps-2.ps1"
|  |  |  |      |  ______________________________start scope Example-Steps-2___
|  |  |  |      |  |
|  |  |  |      |  |  . .steps.ps1
|  |  |  |      |  |  ......................................start 3rd .steps...
|  |  |  |      |  |  $STEPS_STAGE = "branch"
|  |  |  |      |  |  return
|  |  |  |      |  |  ........................................end 3rd .steps...
|  |  |  |      |  |  trap { do_trap }
|  |  |  |      |  |  
|  |  |  |      |  |  do_script   # Example-Steps-2
|  |  |  |      |  |
|  |  |  |      |  |  throw "my error"   # Example-Steps-2                     <<< Example-Steps-2 throws and activates trap
|  |  |  |      |  |
|  |  |  |      |  |  ..........................................call do_trap...
|  |  |  |      |  |  # ( $STEPS_STAGE -eq "branch" )
|  |  |  |      |  |  # ( $global:LASTEXITTRAPPED -eq $null )
|  |  |  |      |  |
|  |  |  |      |  |  $global:LASTEXITTRAPPED = $true
|  |  |  |      |  |  
|  |  |  |      |  |  throw $Error[0].Exception                                <<< Example-Steps-2 propagates error
|  |  |  |      |  |  ...........................................end do_trap...
|  |  |  |      |  |_______________________________end scope Example-Steps-2___
|  |  |  |      |
|  |  |  |      |  .............................................call do_trap...
|  |  |  |      |  # ( $STEPS_STAGE -eq "root" )
|  |  |  |      |  # ( $global:LASTEXITTRAPPED -eq $true )
|  |  |  |      |
|  |  |  |      |  throw $Error[0].Exception                                   <<< 2nd Example-Steps propagates error
|  |  |  |      |  ..............................................end do_trap...
|  |  |  |      |________________________________end scope 2nd Example-Steps___
|  |  |  |
|  |  |  |  }
|  |  |  |  catch {
|  |  |  |      # ( $STEPS_STAGE -eq "init" )
|  |  |  |
|  |  |  |      exit $LASTEXITCODE   # 1st Example-Steps                       <<< 1st Example-Steps/do_exec doesn't propagate error,
|  |  |  |  }
|  |  |  |_______________________________________________________end do_exec___
|  |  |____________________________________________________end 1st do_script___
|  |_____________________________________________end scope 1st Example-Steps___
|
|  # ( $? -eq $false )
|  # ( $LASTEXITCODE -eq 99999 )
|  # ( $LASTEXITMESSAGE -eq "my error")
|  # ( $Error.Count -eq 1 )
|
|  PS > _
|  ...
|   
|_______________________________________________________end scope powershell___

```

##### Notes
  
1. `do_exec` runs a new instance of the script that was calledfrom the outer powershell scope

   Powershell doesn't allow you to implement redirections from within a script (as you can do with `exec` in bash).  The way around this is to call a new instance of the script with the necessary redirections.  The second instance effectively runs the code.

   Care has to be taken that the first instance is not continuing after the second instance completes.  Hence the `break` statement at the end of the `do_exec` function.

2. `do_exec` is called from 1st `do_script` only

   All other instances of `do_script` skip over `do_exec` and effectively output the script-header.

3. `do_exec` uses a try-catch statement to catch the exceptions thrown by the inner scopes, instead of letting the `do_trap` function take care of them 

   The `do_trap` function propagates errors to the calling scope, while the `catch` script block exits with an exitcode.

   By default, the outer powershell scope redirects the error output stream to the success output stream (`2>&1`).  To avoid polluting the outer powershell scope with error messages, the "root" script (the first instance of the script called from the powershell scope) doesn't propagate errors thrown, but instead exits with an exitcode. 

4. `do_exec` uses `break` in successful scenarios, and `exit $LASTEXITCODE` in failure scenarios

   The `exit` command sets `$?` to `$false`, while `break` sets it to `$true`.

5. One could think of avoiding the `do_script`/`do_exec` construct and just run the `do_exec` code at the end of the sourced `.scripts.ps1` script.

   That is no problem for the `break` statement, used in the case of a successful call.  A `break` from a sourced script drops out of the whole tree of scripts/functions that are called from the powershell scope.  
   However, this is a problem with the `exit` statement, used in the case of a failed call.  An `exit` from a sourced script doesn't exit the sourcing script.  This would mean that the code of the sourcing script would be executed a second time, and cause the issue described under point 1.  The code would continue right after the `. .steps.ps1` statement, and execute in the scope of the first instance of the sourcing script.  The code would be executed a second time (without redirections), after the second instance of the sourcing script was already executed in the scope of the sourced `.scripts.ps1` script.

   By letting the first instance of `do_script` call the `do_exec` function, we are moving the execution of the `do_exec` code out of the sourced `.scripts.ps1` script, into the scope of the sourcing script, hence allowing it to properly exit from the sourcing scope.

   Care has to be taken that the `do_script` function is the first command after sourcing `.steps.ps1` and the `trap { do_trap }` statements.  Any other code before the `do_script` function will cause the 'steps' functionality to misbehave when there this code fails.
