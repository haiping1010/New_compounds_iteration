
name='all_file'
#for code in  BA BB BC BD BE BF BG BH BI BJ CA CB CC CD CE CF CG CH CI CJ DA DB DC DD DE DF DG DH DI DJ  

for code in EA EB EC ED EE EF EG EH EI EJ FA FB FC FD FE FF FG FH FI FJ GA GB GC GD GE GF GG GH GI GJ 

#for code in HA HB HC HD HE HF HG HH HI HJ IA IB IC ID IF IG IH II IJ JA JB JC JD JE JF JG JH JI JJ


do
base=$code
mkdir -p 'mp_data_'$base
head -n1 all_file/BAAA_n.csv > $name'/XXXXX_n.txt'
cp -r    ????_pocVec.txt   $name
nohup python  data_process_all.py  $name  'mp_data_'$base  > $base'.log' 2>&1&

sleep 20s
echo $base

done
