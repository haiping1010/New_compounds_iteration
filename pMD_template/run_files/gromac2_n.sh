#!/bin/bash

## Specify the job name
#PBS -N gmxrun



## Join the standard error and the standard output into 1 file output

##PBS -V

## the number of cores must be the same as in the input file for g09
###PBS -l node=1:ncpus=24
#PBS -l select=4:ncpus=24:mpiprocs=24
#PBS -l walltime=240:00:00
#PBS -q long

###PBS -q gpu

## pre-processing script

#export OMP_NUM_THREADS=1


#export MPIPATH=/app/mpi/gcc-4.4.7/openmpi-1.10.2/
#module load cuda/7.5

##/usr/local/openmpi/bin/mpirun -np $NCPUS -machinefile $PBS_NODEFILE /usr/local/gromacs-4.6.2-double/bin/mdrun_mpi  -v -deffnm em
#cd /home/ntu/hzhang02/work/REMD
##bash run_nemd.bash
#-ntomp 1


cd $PBS_O_WORKDIR


##grompp -f md_pull_equitst2.mdp -c npt1.gro -p topol.top -o npt2.tpr  -maxwarn 1&&

mdrun  -nt 96  -s npt2.tpr    -deffnm  npt2   -cpi npt2.cpt   -append





