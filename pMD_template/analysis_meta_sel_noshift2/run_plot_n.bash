

j=0
for i in `ls -1 *fes.dat`
do
    file[j]=$i
    j=`expr $j + 1`
done

echo  ${file[9]},${file[10]},${file[11]},${file[12]},${file[13]}
gnuplot -c 'plot.p_bc2'  ${file[0]%_fes.dat} ${file[1]%_fes.dat} ${file[2]%_fes.dat} ${file[3]%_fes.dat} ${file[4]%_fes.dat} ${file[5]%_fes.dat}  ${file[6]%_fes.dat} ${file[7]%_fes.dat}

mv hbond.png   hbond_1.png

gnuplot -c 'plot.p_bc2'   ${file[8]%_fes.dat}  ${file[9]%_fes.dat}  ${file[10]%_fes.dat} ${file[11]%_fes.dat}  ${file[12]%_fes.dat} ${file[13]%_fes.dat}  ${file[14]%_fes.dat}  ${file[15]%_fes.dat}

mv hbond.png   hbond_2.png







