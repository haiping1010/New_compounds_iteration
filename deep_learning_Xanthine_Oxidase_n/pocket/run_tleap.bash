for name in  *_poc_ter.pdb
do 

base=${name%_poc_ter.pdb}
sed "s/XXXXX/$base/g"  test.leapin  > test_n.leapin

tleap -f test_n.leapin


done
