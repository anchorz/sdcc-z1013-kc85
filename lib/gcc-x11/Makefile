all: obj gcc-conio-x11.a

obj:
	mkdir obj

gcc-conio-x11.a: obj/krt.o obj/z1013.o obj/conio.o obj/gcc-x11.o
	ar r $@ $^

obj/%.o: src/%.c
	gcc -g -Wall -pedantic -std=gnu99 -Werror -c -o $@ -I../../include-gcc/ -I/usr/X11/include $< 

clean:
	rm -f *.a
	rm -f *~
	rm -f src/*~ 
	rm -rf obj
