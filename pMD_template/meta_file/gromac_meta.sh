#!/bin/bash

## Specify the job name
#PBS -N gmxrun



## Join the standard error and the standard output into 1 file output

##PBS -V

## the number of cores must be the same as in the input file for g09
#PBS -l select=10:ncpus=24:mpiprocs=24
#PBS -l walltime=24:00:00
#PBS -q normal

##PBS -q gpu

## pre-processing script

#export OMP_NUM_THREADS=1


##/usr/local/openmpi/bin/mpirun -np $NCPUS -machinefile $PBS_NODEFILE /usr/local/gromacs-4.6.2-double/bin/mdrun_mpi  -v -deffnm em
#cd /home/ntu/hzhang02/work/REMD
##bash run_nemd.bash
#-ntomp 1


#cd $PBS_O_WORKDIR

mpirun  -np 1    gmx_mpi grompp -f prod.mdp -c npt2.gro -p topol.top -o prod.tpr -maxwarn 1 -n index.ndx&&
mpirun -np 8   gmx_mpi mdrun  -deffnm prod -plumed plumed.dat -mp topol.top 















