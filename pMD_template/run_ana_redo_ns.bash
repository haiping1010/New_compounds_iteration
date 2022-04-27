

echo  -e "1\n13\n" | gmx_mpi rms -s em.tpr -f  npt2_out.xtc -o  rms_out.xvg  -tu ns
: '
echo 1 | gmx_mpi rmsf -s em.tpr -f  md_0_1_out.xtc -o  rmsf_out.xvg

echo -e "1\n13\n" | gmx_mpi hbond -s em.tpr -f  md_0_1_out.xtc -num  hbond.xvg

echo  12 | gmx_mpi  energy  -s em.tpr -f  md_0_1.edr -o   energy.xvg 


echo 1 | gmx_mpi rmsf -s em.tpr -f  md_0_1_out.xtc -o  rmsf_out_res.xvg -res

'

#gnuplot plot.p











