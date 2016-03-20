all:
	cd lib; make

clean:
	rm -f *.bak
	rm -f *~
	rm -f tools/*.bak
	rm -f tools/*~
	rm -f mk/*.bak
	rm -f mk/*~
