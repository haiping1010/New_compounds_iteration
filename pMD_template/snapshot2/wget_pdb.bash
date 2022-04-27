cat    list.txt | while read  line
do

cp -r  ../$line'_run'/npt2.gro    $line'.gro'
cp -r ../$line'_run'/npt2_out.xtc    $line'_npt2_out.xtc'

cd ../$line'_run'
echo 0 | gmx_mpi trjconv -s em.tpr -f  npt2.gro -o  npt2_outx.gro  -pbc  nojump
echo 0 | gmx_mpi trjconv -s em.tpr -f  npt2_outx.gro -o  npt2_out.pdb   -pbc mol

cd  ../snapshot2/

cp -r ../$line'_run'/npt2_out.pdb    $line'_npt2_out.pdb'

grep -v 'SOL \|CL    CL\|NA    NA'     $line'_npt2_out.pdb'  >   $line'_npt2_out_n.pdb'


done
