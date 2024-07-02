#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem
#SBATCH --account=blanca-biokem
#SBATCH --job-name=minimization
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

source /programs/sbgrid.shrc
NAME=''

#run the first minimization
mpirun -np 20 pmemd.MPI -O -i min1.in -o ../outputs/min1.out -p ../${NAME}_buffer.prmtop -c ../${NAME}_buffer.inpcrd -r ../restarts/${NAME}_min1.rst\
 -x ../trajectories/${NAME}_min1.nc -inf ../mdinfo/${NAME}_min1.mdinfo -ref ../${NAME}_buffer.inpcrd

#run the second minimization
mpirun -np 20 pmemd.MPI -O -i min2.in -o ../outputs/min2.out -p ../${NAME}_buffer.prmtop -c ../restarts/${NAME}_min1.rst -r ../restarts/${NAME}_min2.rst\
 -x ../trajectories/${NAME}_min2.nc -inf ../mdinfo/${NAME}_min2.mdinfo

sbatch 5_heat_and_equilibrate.q

