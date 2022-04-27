for name in *poc_ter.pdb
do
	base=${name%_poc_ter.pdb}
python replace_index.py  $name
sed -i 's/ A /   /g'   $base'_npt2_out_n_f.pdb'

done
