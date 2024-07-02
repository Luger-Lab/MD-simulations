#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=blanca
#SBATCH --account=blanca-biokem
#SBATCH --job-name=equilibrate
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=2
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

source /programs/sbgrid.shrc
NAME=''

pmemd.cuda -O -i gpu_in/eq_GB.in \
              -o ../outputs/${NAME}_eq.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_min.rst \
              -r ../restarts/${NAME}_eq.rst \
              -x ../trajectories/${NAME}_eq.nc \
              -inf ../mdinfo/${NAME}_eq.mdinfo \
              -ref ../restarts/${NAME}_min.rst
