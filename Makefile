a.out.c: c.tcl
	@tclsh c.tcl > a.out.c
	cat a.out.c

a.out: a.out.c
	cc a.out.c 

run: a.out
	./a.out

clean:
	if [ -e a.out ]; then trash a.out; fi
	if [ -e a.out.c ]; then trash a.out.c; fi

.PHONY: clean a.out run a.out.c
