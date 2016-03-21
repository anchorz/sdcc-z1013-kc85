LIBS=$(wildcard sample_*)

.PHONY: force

all: $(LIBS)
	cd lib; make

$(LIBS): force
	cd $@ && make

clean:
	for name in $(LIBS); do cd $$name; make clean; cd ..; done
	rm -f *.bak
	rm -f *~
	rm -f tools/*.bak
	rm -f tools/*~
	rm -f mk/*.bak
	rm -f mk/*~
