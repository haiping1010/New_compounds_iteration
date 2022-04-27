for name in  ????-????_complex_n.pdb
do

base=${name%_complex_n.pdb}
echo $name
grep ' UNL '   $name  > $base'_lig.pdb'


done
