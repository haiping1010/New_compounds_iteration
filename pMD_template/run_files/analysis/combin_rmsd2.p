set terminal png size 1000,1000 enhanced font "Helvetica,20"
set output outputname
set yrange [0:10]
set ylabel "RMS deviation";set xlabel "Simulation Time";plot filename using 1:2 title 'With ref of normal PH' w l lc 3
 
