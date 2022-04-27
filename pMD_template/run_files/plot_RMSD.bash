
for i in *xvg
do
gnuplot -e "filename='${i}'; outputname='${i}noanti.png'" combin_rmsd2.p
done

