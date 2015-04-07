# ChangeTrackedVariable.tcl
**Problem:**
I wanted to add a write trace to a variable, but only get called back when the value actually changed.

**Example:**
```
proc report {args} {puts "status changed to: $::status"}
trace add variable status write report
set status Unknown; # -> status changed to: Unknown
set status Unknown; # -> status changed to: Unknown
set status Unknown; # -> status changed to: Unknown
set status Idle; # -> status changed to: Idle
set status Idle; # -> status changed to: Idle
set status Idle; # -> status changed to: Idle`
```
As you can see, the write callback fires even when the "new" value is the same.

**Solution:**
A simple TclOO object that only fires the callback when the written value is new.

**Example:**

```
package require change_tracked_variable
proc report {} {puts "status changed to [status get]"}
change_tracked_variable create status Unknown report
set status Unknown; # -> status changed to: Unknown
set status Unknown; # ->
set status Unknown; # ->
set status Idle; # -> status changed to: Idle
set status Idle; # ->
set status Idle; # ->
```
Now when I'm polling some device for status and it keeps telling me "I'm Idle, I'm Idle, I'm Idle,..." I can handle the first and ignore the rest.

## How to make it available for use:

1. Take the Tcl module file and drop it into `<TclInstallRoot>\lib\tcl8\8.6\`
2. Rename it to change_tracked_variable-0.0.3.tm
3. `package require change_tracked_variable`
