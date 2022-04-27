for name in  ????_ligand_n.mol2

do
base=${name%.mol2}
echo $name
babel  -imol2 $name  -omol2  $base'_h.mol2' -h
acpype   -i   $base'_h.mol2'  

done
