for name in   ???_seq_complex_n_0001_????.pdb
do

base=${name%.pdb}
echo $name

grep -v ' B '  $name  > RDRP.pdb
grep '^ATOM\|^TER\|^END' RDRP.pdb  > RDRP_w.pdb
grep ' B '   $name  > $base'_lig.pdb'
babel -ipdb $base'_lig.pdb'  -omol2  $base'_lig.mol2'

python extract_pocket_ter_n.py $base

done
