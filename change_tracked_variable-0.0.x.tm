package provide change_tracked_variable 0.0.1
package require TclOO

oo::class create change_tracked_variable {
    variable _variable _callback

    constructor {initial_value callback} {
        set _variable $initial_value
        set _callback $callback
        $_callback
    }

    method set {new_value} {
        if {$new_value != $_variable} {
            set _variable $new_value
            $_callback
        }
    }

    method get {} {
        return $_variable
    }
}
