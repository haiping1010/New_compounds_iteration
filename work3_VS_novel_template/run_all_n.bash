
name='all_file'
for code in   gen0{1..6}
#for code in  JD JE JF JG JH JI JJ

do
base=$code
mkdir -p 'mp_data_'$base
#head -n1 all_file/BAAA_n.csv > $name'/XXXXX_n.txt'
cp -r    *_pocVec.txt   $name
nohup python  data_process_all.py  $name  'mp_data_'$base  > $base'.log' 2>&1&

sleep 2s
echo $base

done
