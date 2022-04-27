for name in ????.pdb
do
base=${name%.pdb}
grep -v ' HOH '  $name > $base'_nowater.pdb'
grep  -r  '^HETATM'   $base'_nowater.pdb'  > $base'_ligands.pdb'
grep   "^ATOM\|TER\|END"   $name  > $base'_w.pdb'

done
~         
