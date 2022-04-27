rm out_QED_score.txt
for name in CH*.sdf
do

	python  check_QED_n.py  $name >> out_QED_score.txt

done
