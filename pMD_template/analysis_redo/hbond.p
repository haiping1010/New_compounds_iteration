set terminal png size 2000,500 enhanced font "Times New Roman,40"
set samples 1000
set ytics  2

set yrange [0:8]
set xrange  [0:100]
set ylabel "Hbond number";set xlabel "Simulation time (ns)"

set output ARG2
plot ARG1 using 1:2 title "Hbond number between M protease and ".ARG3  w l lc "blue" lw 2


#plot "apo_MD_site1_n_hbond.xvg" using 1:2 title 'Ligand binding in site1' w l lc "blue" lw 2  smooth cspline, "apo_MD_site2_n_hbond.xvg" using 1:2 title 'Ligand binding in site2' w l lc "red" lw 2  smooth cspline, "apo_MD_site1_site2_n_hbond1.xvg" using 1:2 title 'Ligand with site1 for simulation Group 4' w l lc "green" lw 2 smooth cspline,"apo_MD_site1_site2_n_hbond2.xvg" using 1:2 title 'Ligand with site2 for simulation Group 4' w l lc "yellow" lw 2 smooth cspline
