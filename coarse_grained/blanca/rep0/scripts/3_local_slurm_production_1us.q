#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=blanca
#SBATCH --account=blanca-biokem
#SBATCH --job-name=1us_md
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=A100|A40
#SBATCH --ntasks=2
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME=''

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_1us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_eq.rst \
              -r ../restarts/${NAME}_1us.rst \
              -x ../trajectories/${NAME}_1us.nc \
              -inf ../mdinfo/${NAME}_1us.mdinfo


