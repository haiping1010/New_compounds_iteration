  set terminal png size 1800,1000 enhanced font "Helvetica,20"
set output "hbond.png"
#set xrange [0:20000]

set title font ',10' 
set label font ',10'

set xtics font ", 30"
set ytics font ", 30"
set tics font ", 30"
set key font ",30"
set yrange [0:1800]

#between nitrogenous bases
#set arrow from 2100,0 to 2100,22 nohead lc 0 lw 3 dt "."

set style line 1 lc rgb "black" lw 4
set style line 2 lc rgb "red"  lw 4
set style line 3 lc rgb "green"  lw 4
set style line 4 lc rgb "blue"   lw 2.5 

set style line 5 lc rgb "cyan"  lw 4
set style line 6 lc rgb "magenta"  lw 2.5  
set style line 7 lc rgb "yellow"   lw 4
set style line 8 lc rgb "dark-yellow"  lw 2.5  
set style line 9 lc rgb "light-blue"  lw 2.5
set style line 10 lc rgb "light-green"  lw 2.5
set style line 11 lc rgb "dark-red"  lw 2.5

#smooth  csplines

set ylabel 'FES(kJ/mol)' font ", 30";set xlabel "Coordination number (ns)" font ", 30";set y2label  ' ';
set title font ',10'
set label font ',10'
set key font ",20"
set samples 50
plot  ARG1.'_run_fes.dat' using 1:2 title ARG1   ls 1  w l    smooth  csplines   ,\
ARG2.'_run_fes.dat' using 1:2 title ARG2    w l   ls 2  smooth  csplines, \
ARG3.'_run_fes.dat' using 1:2 title  ARG3  w l    ls 3 smooth  csplines,\
ARG4.'_run_fes.dat' using 1:2 title ARG4    w l  ls 4 smooth  csplines,\
ARG5.'_run_fes.dat' using 1:2 title ARG5   w l    ls 5 smooth  csplines ,\
ARG6.'_run_fes.dat' using 1:2 title ARG6   w l    ls  6    smooth  csplines  ,\
ARG7.'_run_fes.dat' using 1:2 title ARG7   w l    ls 7  smooth  csplines ,\
ARG8.'_run_fes.dat' using 1:2 title ARG8   w l    ls 8    smooth  csplines ,\
ARG9.'_run_fes.dat' using 1:2 title ARG9   w l    ls 9      smooth  csplines,\
'f871-0960_run_fes.dat'  using 1:2 title 'f871-0960'   w l    ls 10  smooth  csplines  ,\
'v013-9764_run_fes.dat' using 1:2 title 'f871-0960'   w l    ls 11    smooth  csplines 
#f871-0960_run_fes.dat,v013-9764_run_fes.dat

#substr("str",i,j)
#filename2 using 1:2 title 'H\_bonds between two parts of stem 2'  w l     lw 3 lc "blue", filename3 using 1:2 title 'H\_bonds between stem 1 and loop 2'    w l     lw 3 lc "green"
