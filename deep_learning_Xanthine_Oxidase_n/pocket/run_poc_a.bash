for name in  *_lig_n.pdb

do

base=${name%_lig_n.pdb}

babel -ipdb  $name   -omol2   $base'_lig.mol2'
python  extract_pocket_ter_n.py  $base



done
