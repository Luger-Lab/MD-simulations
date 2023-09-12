#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=heating
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=A100|A40
#SBATCH --ntasks=8
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

ml amber/v22

NAME='bd0055_rna'

pmemd.cuda -O -i heat.in\
 -p ../${NAME}.prmtop -c ../restarts/${NAME}_min.rst -ref ../restarts/${NAME}_min.rst\
 -o ../outputs/heat.out -x ../trajectories/${NAME}_heat.nc -inf ../mdinfo/${NAME}_heat.info\
 -r ../restarts/${NAME}_heat.rst
