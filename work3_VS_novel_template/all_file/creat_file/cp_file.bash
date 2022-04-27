
cat  all_energies_-9.0.txt  | while read line
do

IFS=' ' read -r -a array <<< $line
##wget 'http://zinc15.docking.org/substances/'${array[0]}'.sdf'

cp -r  ../${array[0]}'.sdf'    'CHEMID_1_'${array[0]:6 }'.sdf'
done
