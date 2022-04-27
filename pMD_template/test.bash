cat  ligand_inf.txt  | while read line  
do

IFS=' ' read -r -a array <<< $line
base=${array[0]%.pdb}


#echo  $base'_ligands.pdb'

xx=" "${array[1]}
if [ ${#array[@]} == 3 ]; then
   grep  -r    "${array[2]}"   $base'_ligands.pdb' | grep   "${array[1]}"
   #| grep -r  $xx

fi



done

