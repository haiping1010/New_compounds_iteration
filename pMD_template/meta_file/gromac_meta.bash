#!/bin/bash
export CUDA_VISIBLE_DEVICES=0


gmx_mpi make_ndx  -f  npt2.gro   -o   tst.ndx <<<'q
'

gmx_mpi grompp -f prod.mdp -c npt2.gro  -r npt2.gro -p topol.top -o prod.tpr -maxwarn 1 -n tst.ndx &&
gmx_mpi mdrun  -deffnm prod -plumed plumed.dat -mp topol.top  -ntomp 4














