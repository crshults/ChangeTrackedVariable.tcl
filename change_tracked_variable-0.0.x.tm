package provide change_tracked_variable 0.0.3
package require TclOO

oo::class create change_tracked_variable {
    variable _variable _default _callback

    constructor {initial_value callback} {
        set _variable $initial_value
        set _default  $initial_value
        set _callback $callback
        $_callback
    }

    method set {new_value {custom_callback {}}} {
        if {$new_value != $_variable} {
            set _variable $new_value
            $_callback
            eval $custom_callback
        }
    }

    method get {} {
        return $_variable
    }

    method reset {} {
        my set $_default
    }
}
