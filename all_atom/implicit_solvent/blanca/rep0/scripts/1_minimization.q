#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=minimization
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=A100|A40
#SBATCH --ntasks=8
#SBATCH --mem=128gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

ml amber/v22

NAME='bd0055_rna'

pmemd.cuda -O -i min.in\
 -p ../${NAME}.prmtop -c ../${NAME}.inpcrd -o ../outputs/min.out\
 -x ../trajectories/${NAME}_min.nc -inf ../mdinfo/${NAME}_min.info\
 -r ../restarts/${NAME}_min.rst
