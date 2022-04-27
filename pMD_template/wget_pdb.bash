cat download.txt | while read  line
do

wget   https://files.rcsb.org/download/$line'.pdb'


done
