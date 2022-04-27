#for name in *_complex.pdb

cat   charge.txt  | while read line

do

IFS=' ' read -r -a array <<< $line
name=${array[0]}
charge=${array[1]}
base=${name%_lig_n.mol2}


#grep  ' UNL '  $base'_complex_n.pdb'  > $base'_lig_n.pdb'

#babel -ipdb  $base'_lig.pdb' -opdb  $base'_lig_n.pdb'  -h

acpype -i  $base'_lig_n.mol2'   -n ${array[1]}

done
