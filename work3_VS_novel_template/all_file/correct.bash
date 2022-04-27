for name in *.smi
do
	base=${name%.smi}
	python    read_in_out.py  $name >  $base'_n.smi'




done
