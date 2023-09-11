#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=blanca
#SBATCH --account=blanca-biokem
#SBATCH --job-name=equilibrate
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=A100|A40
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/20
NAME='bac_40_2x_CG'

pmemd.cuda -O -i gpu_in/eq_GB.in \
              -o ../outputs/${NAME}_eq.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_min.rst \
              -r ../restarts/${NAME}_eq.rst \
              -x ../trajectories/${NAME}_eq.nc \
              -inf ../mdinfo/${NAME}_eq.mdinfo \
              -ref ../restarts/${NAME}_min.rst
