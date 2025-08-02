run: a.out
	./a.out

a.out: a.out.c
	cc a.out.c 

a.out.c: c.tcl
	tclsh c.tcl > a.out.c
