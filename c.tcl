


namespace eval c {
    set compiler(indent) 0

    proc _out {args} {
        foreach arg $args {
            puts -nonewline $arg
        }
    }
    proc _indent {} {
        variable compiler
        for {set i 0} {$i < $compiler(indent) } {incr i} {
            _out "    "
        }
    }

    proc _fn_params {params} {
        _out "("
        set comma false 
        foreach param $params {
            if $comma {
                _out ", "
            }
            _out [lindex $param 0]
            _out " "
            _out [lindex $param 1]
            set comma true
        }
        _out ")"
    }

    proc fn {ret name params body} {
        variable compiler
        _out $ret " " $name
        _fn_params $params
        _out " {\n"
        incr compiler(indent) 1
        foreach stmt [split $body \n] {
            eval $stmt
        }
        incr compiler(indent) -1 
        _out "}\n"
    }

    proc printf {str} {
        _indent
        #_out "#file" [dict get [info frame -1] file] \n
        _out {printf("%s", "} $str {");} \n
    }

    proc include {header} {
        _out #include " " $header \n\n
    }
}

c::include <stdio.h>

c::fn int main {{int argc} {char** argv}} {
    c::printf "hello world\\n"
    c::printf "foo\\n"
    c::printf "bar\\n"
}
