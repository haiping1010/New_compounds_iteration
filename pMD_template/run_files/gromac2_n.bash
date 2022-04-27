#!/bin/bash


#export CUDA_VISIBLE_DEVICES=0,1
gmx_mpi  grompp -f md_pull_equitst2.mdp -c npt1.gro -p topol.top -o npt2.tpr  -maxwarn 1
#mpirun -np  4  gmx_mpi mdrun    -s npt2.tpr    -deffnm  npt2  

mpirun -np  4  gmx_mpi mdrun   -s npt2.tpr    -deffnm  npt2 



