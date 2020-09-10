#!/bin/bash

module load cuda/8.0 anaconda/2 mpi amber
NAME='2M_KCL_hpya_DNA_no_loop'

#run the first minimization
mpirun -np 9 pmemd.MPI -O -i min1.in -o ../outputs/min1.out -p ../${NAME}_buffer.prmtop -c ../${NAME}_buffer.inpcrd -r ../restarts/${NAME}_min1.rst\
 -x ../trajectories/${NAME}_min1.nc -inf ../mdinfo/${NAME}_min1.mdinfo -ref ../${NAME}_buffer.inpcrd

#run the second minimization
mpirun -np 9 pmemd.MPI -O -i min2.in -o ../outputs/min2.out -p ../${NAME}_buffer.prmtop -c ../restarts/${NAME}_min1.rst -r ../restarts/${NAME}_min2.rst\
 -x ../trajectories/${NAME}_min2.nc -inf ../mdinfo/${NAME}_min2.mdinfo
