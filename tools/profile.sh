#perl -lpe '$_=hex' file.txt | \
#paste -d" " - file.txt  | \
#sort -n | \
#cut -d" " -f 2-

cut -b 69- line.txt >cutted.txt
perl -lpe '$_=hex' cutted.txt | paste -d" " -  cutted.txt | sort -n >sorted.txt
uniq -c sorted.txt | sort -nr >profiled.txt

