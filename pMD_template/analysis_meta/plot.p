  set terminal png size 1200,1000 enhanced font "Helvetica,20"
set output ARG2
#set xrange [0:20000]

set xtics font ", 30"
set ytics font ", 30"
set tics font ", 30"
set key font ",30"
#set yrange [0:10]

#between nitrogenous bases
#set arrow from 2100,0 to 2100,22 nohead lc 0 lw 2 dt "."

set ylabel 'Number of H\_bonds' font ", 30";set xlabel "Simulation Time (ns)" font ", 30";set y2label  ' ';
plot  ARG1 using 1:2 title 'energy'   w l  smooth csplines  lw 2 

#filename2 using 2:3 title 'H\_bonds between two parts of stem 2'  w l  smooth csplines   lw 2 lc "blue", filename3 using 2:3 title 'H\_bonds between stem 1 and loop 2'    w l  smooth csplines   lw 2 lc "green"
