#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=blanca
#SBATCH --account=blanca-biokem
#SBATCH --job-name=minimization
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=40gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

source /programs/sbgrid.shrc
NAME=''

#run the first minimization
mpirun -np 8 pmemd.MPI -O -i cpu_in/em_GB.in -o ../outputs/min.out -p ../${NAME}.prmtop -c ../${NAME}.nc -r ../restarts/${NAME}_min.rst\
 -x ../trajectories/${NAME}_min.nc -inf ../mdinfo/${NAME}_min.mdinfo -ref ../${NAME}.nc

