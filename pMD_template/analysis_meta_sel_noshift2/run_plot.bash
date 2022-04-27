

j=0
for i in `ls -1 *fes.dat`
do
    file[j]=$i
    j=`expr $j + 1`
done

echo  ${file[9]},${file[10]},${file[11]},${file[12]},${file[13]}
gnuplot -c 'plot.p_bc'  ${file[0]%_fes.dat} ${file[1]%_fes.dat} ${file[2]%_fes.dat} ${file[3]%_fes.dat} ${file[4]%_fes.dat} ${file[5]%_fes.dat} 

mv hbond.png   hbond_1.png

gnuplot -c 'plot.p_bc'  ${file[6]%_fes.dat} ${file[7]%_fes.dat} ${file[8]%_fes.dat}  ${file[9]%_fes.dat}  ${file[10]%_fes.dat} ${file[11]%_fes.dat}

mv hbond.png   hbond_2.png


gnuplot -c 'plot.p_bc'  ${file[12]%_fes.dat} ${file[13]%_fes.dat}   ${file[15]%_fes.dat}  ${file[16]%_fes.dat} ${file[17]%_fes.dat}

mv hbond.png   hbond_3.png

gnuplot -c 'plot.p_bc'  ${file[18]%_fes.dat} ${file[19]%_fes.dat} ${file[20]%_fes.dat}  ${file[21]%_fes.dat}  ${file[22]%_fes.dat} ${file[23]%_fes.dat}

mv hbond.png   hbond_4.png


for name in *fes.dat
do
	gnuplot -c plot.p  $name  $name'.png'

done

