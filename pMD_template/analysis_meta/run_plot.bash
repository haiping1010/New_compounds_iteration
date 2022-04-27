

j=0
for i in `ls -1 *fes.dat`
do
    file[j]=$i
    j=`expr $j + 1`
done

echo  ${file[9]},${file[10]},${file[11]}
gnuplot -c 'plot.p_bc'  ${file[0]%_run_fes.dat} ${file[1]%_run_fes.dat} ${file[2]%_run_fes.dat} ${file[3]%_run_fes.dat} ${file[4]%_run_fes.dat} ${file[5]%_run_fes.dat} ${file[6]%_run_fes.dat} ${file[7]%_run_fes.dat} ${file[8]%_run_fes.dat}  ${file[9]%_run_fes.dat} 



for name in *fes.dat
do
	gnuplot -c plot.p  $name  $name'.png'

done
