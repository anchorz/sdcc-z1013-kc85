all: obj gcc-conio-x11.a

obj:
	mkdir obj

gcc-conio-x11.a: obj/conio.o obj/gcc-x11.o
	ar r $@ $^

obj/%.o: src/%.c
	gcc -Wall -pedantic -c -o $@ $< 

clean:
	rm -f *~
	rm -f src/*~ 
	rm -rf obj
