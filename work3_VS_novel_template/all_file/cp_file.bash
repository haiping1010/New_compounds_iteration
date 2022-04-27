mkdir final_sel

grep " 1$"   out_QED_score.txt > out_QED_score_druglike.txt
cat  out_QED_score_druglike.txt | while read line
do

IFS=' ' read -r -a array <<< $line
##wget 'http://zinc15.docking.org/substances/'${array[0]}'.sdf'

cp -r ${array[0]}  final_sel

done
