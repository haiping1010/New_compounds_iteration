set terminal png size 1000,1000 enhanced font "Helvetica,20"
#set samples 1000
set output "rmsf.png"
set yrange [0:1]

set xtics 0,300,4000

set ylabel "Rmsf of atom (nm)";set xlabel "Atom number"
#plot "Plot_data.txt" using 1:4 title 'auc of training vs dropout precentage' w l lc "blue" lw 5,"Plot_data.txt" using 1:2 title 'auc of validation vs dropout precentage' w l lc "green" lw 5 , "Plot_data.txt" using 1:5 title 'accuracy  of training vs dropout precentage' w l lc "red" lw 5,"Plot_data.txt" using 1:3 title 'accuracy of validation vs dropout precentage' w l lc "yellow" lw 5
plot "apo_MD_n_rmsf_out.xvg" using 1:2 title 'Apo' w l lc "blue" lw 2  , "apo_MD_site1_n_rmsf_out.xvg" using 1:2 title 'Ligand binding in site1' w l lc "red" lw 2  , "apo_MD_site2_n_rmsf_out.xvg" using 1:2 title 'Ligand binding in site2' w l lc "green" lw 2 ,"apo_MD_site1_site2_n_rmsf_out.xvg" using 1:2 title 'Ligand binding in site1 and site2' w l lc "yellow" lw 2 
