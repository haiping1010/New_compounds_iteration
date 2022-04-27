export CUDA_VISIBLE_DEVICES=1

gmx_mpi grompp -f minim.mdp -c solv_ions.gro -r solv_ions.gro  -p topol.top -o em.tpr&&
gmx_mpi mdrun -v -deffnm em  -ntomp 4 &&

gmx_mpi grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr &&
gmx_mpi mdrun -v -deffnm nvt   -ntomp 4 &&

gmx_mpi grompp -f md_pull_equitst.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt1.tpr  &&
gmx_mpi mdrun -deffnm npt1    -ntomp 4   &&


gmx_mpi grompp -f md_pull_equitst2.mdp -c npt1.gro -r npt1.gro -p topol.top -o npt2.tpr  &&
gmx_mpi mdrun -deffnm npt2    -ntomp  4




#mpirun -np 10      gmx_mpi mdrun -s npt2.tpr -cpi state.cpt

