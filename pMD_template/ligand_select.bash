cat  ligand_inf.txt  | while read line  
do

IFS=' ' read -r -a array <<< $line
base=${array[0]%.pdb}

#echo ${#array[@]}
if [ ${#array[@]} == 3 ]; then
   grep      ${array[2]}   $base'_ligands.pdb' | grep  " ${array[1]}"  > $base'_ligand_n.pdb'

fi
grep  "^TER\|^END\|^ATOM"   $base'.pdb'| grep  " ${array[1]}"  > $base'_w.pdb'

echo ${array[2]}
echo $base'_w.pdb'



done

