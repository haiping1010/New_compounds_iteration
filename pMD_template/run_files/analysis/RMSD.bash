#echo 0 | trjconv_mpi -s npt2.tpr -f npt2.xtc -o npt2_noPBC.xtc -pbc mol -ur compact&&
echo -e "22\n 22\n"|  gmx_mpi trjconv  -s npt2.tpr -f npt2.xtc -o npt2_noPBC.xtc -pbc mol -ur compact -n index_n.ndx -center
echo -e "22\n22\n" | gmx_mpi  rms -s npt2.tpr -f npt2_noPBC.xtc -o rmsd.xvg -tu ns -n index_n.ndx
echo -e "22\n13\n" | gmx_mpi  rms -s npt2.tpr -f npt2_noPBC.xtc -o rmsd1.xvg -tu ns -n index_n.ndx
echo -e "13\n13\n" | gmx_mpi  rms -s npt2.tpr -f npt2_noPBC.xtc -o rmsd2.xvg -tu ns -n index_n.ndx
gnuplot rmsd.p

gmx_mpi  hbond -f npt2.xtc -s npt2.tpr -num hbond.xvg -tu ns

