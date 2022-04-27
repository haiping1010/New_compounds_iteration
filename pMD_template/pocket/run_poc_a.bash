for name in   *_lig_n.mol2

do

base=${name%_lig_n.mol2}

python  extract_pocket_ter_n.py  $base



done
