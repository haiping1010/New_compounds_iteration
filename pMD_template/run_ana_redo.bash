
echo 0 | gmx_mpi trjconv -s em.tpr -f  npt2.xtc -o  npt2_outx.xtc  -pbc  nojump -dt 100
echo -e "1\n0\n" | gmx_mpi trjconv -s em.tpr -f  npt2_outx.xtc -o  npt2_out.xtc  -pbc mol  -ur compact  -center 
#echo 0 | gmx_mpi trjconv -s em.tpr -f  npt2.xtc -o  npt2_out.xtc  -pbc nojump -ur compact -dt 100

echo 0 | gmx_mpi trjconv -s em.tpr -f  npt1.gro -o  npt2_outx.gro  -pbc  nojump -dt 100
echo -e "1\n0\n" | gmx_mpi trjconv -s em.tpr -f  npt2_outx.gro -o  npt2_out.gro  -pbc mol  -ur compact  -center

echo  -e "1\n13\n" | gmx_mpi rms -s  npt2_out.gro   -f  npt2_out.xtc -o  rms_out_lig.xvg  -tu ns
echo  -e "1\n3\n" | gmx_mpi rms -s  npt2_out.gro   -f  npt2_out.xtc -o  rms_out_CA.xvg  -tu ns

: '
echo 1 | gmx_mpi rmsf -s em.tpr -f  md_0_1_out.xtc -o  rmsf_out.xvg

echo -e "1\n13\n" | gmx_mpi hbond -s em.tpr -f  md_0_1_out.xtc -num  hbond.xvg

echo  12 | gmx_mpi  energy  -s em.tpr -f  md_0_1.edr -o   energy.xvg 


echo 1 | gmx_mpi rmsf -s em.tpr -f  md_0_1_out.xtc -o  rmsf_out_res.xvg -res

'

#gnuplot plot.p











